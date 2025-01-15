# **LAB 3: Comparative Inference Benchmarking on ARM Server and Edge Devices**

## Introduction

Welcome to Lab 3 in our series on **Optimizing Generative AI Workloads with ARM Processors**! In this lab, we shift our focus to evaluating the performance constraints of generative AI inference between ARM-based server and edge devices. Specifically, we'll use the **OpenELM-3B** model alongside the popular **llama.cpp** framework to benchmark and compare inference characteristics on two different ARM environments: a high-performance Graviton server and a resource-constrained Raspberry Pi.

Throughout this lab, you will:

- **Benchmark Latency Metrics**: Measure and compare the overall inference latency, time-to-first-token (TTFT), and per-token decoding latency across devices.
- **Evaluate Memory Consumption**: Analyze how the OpenELM-3B model's memory footprint varies between an ARM server and an ARM-based edge device.
- **Compare ARM CPU Constraints**: Understand the practical limitations and trade-offs when deploying large language models on different ARM CPUs, from powerful server-class processors to limited edge devices.
- **Utilize llama.cpp Framework**: Leverage the llama.cpp framework for efficient model inference and performance measurement, allowing for cross-device comparisons.

This lab will guide you through setting up the necessary environments, running inference benchmarks on both the Raspberry Pi and Graviton server, and interpreting the results. By the end of the lab, you'll gain insights into:

- How hardware differences affect model performance
- Strategies for optimizing inference on both server and edge ARM devices
- Best practices for deploying large language models across diverse ARM architectures

---

### **Lab Objectives**

1. **Set Up Diverse ARM Environments**  
   Prepare and configure both a Raspberry Pi (edge device) and an ARM Graviton server for inference benchmarking with the OpenELM-3B model and llama.cpp framework.

2. **Benchmark Latency Metrics**  
   Measure key performance indicators, including total inference latency, time-to-first-token (TTFT), and per-token decoding latency, on both devices.

3. **Analyze Memory Consumption**  
   Monitor and compare memory utilization during model inference to assess resource constraints on server and edge devices.

4. **Compare Performance Constraints**  
   Understand the practical implications of deploying large language models on resource-constrained edge devices versus powerful server environments. Identify bottlenecks and optimization opportunities for each scenario.

5. **Document Findings and Insights**  
   Compile your observations, compare the differences in performance, and suggest strategies to mitigate limitations on edge devices while leveraging server capabilities.

---

### **Prerequisites**

- **Basic Understanding of Linux**: Familiarity with Linux command-line operations and system configuration.
- **Experience with C/C++ and Python Programming**: Ability to modify, compile, and execute code across different ARM platforms.
- **Fundamentals of AI Inference**: Knowledge of how inference works in large language models.
- **Completion of Labs 1 and 2 (Recommended)**: Prior experience with ARM intrinsics, quantization, and performance benchmarking for generative AI workloads.

---

**By the end of this lab**, you will have a comprehensive understanding of how ARM server and edge CPUs handle inference for large language models like OpenELM-3B. You will be equipped with the skills to benchmark and analyze latency, time-to-first-token, decoding performance, and memory consumption, enabling you to make informed decisions when deploying AI models across diverse ARM architectures.




## Setting Up the Raspberry Pi for Inference Benchmarking

Before proceeding, ensure you have completed the [Lab 1 setup script](#) on your Raspberry Pi. If not, start by running the setup script:

```bash
./setup_pi5.sh
```

Once the script completes, activate the newly created virtual environment:

```bash
source pi5_env/bin/activate
```

This ensures that all required packages for the lab are preinstalled.

### Building the llama.cpp Inference Framework

If you haven't already, download and build the [llama.cpp](https://github.com/ggerganov/llama.cpp) inference framework with ARM CPU optimizations:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/ggerganov/llama.cpp
   ```

2. **Configure the build:**

   ```bash
   cmake -B llama.cpp/build -S llama.cpp -DCMAKE_CXX_FLAGS="-mcpu=native" -DCMAKE_C_FLAGS="-mcpu=native"
   ```

3. **Compile the framework:**

   ```bash
   cmake --build llama.cpp/build --config Release -j$(nproc) -v
   ```

These commands build the framework optimized for your ARM CPU.

### Downloading the OpenELM-3B Model Weights

Next, download the large language model weights from Hugging Face. Follow these steps:

1. Create a Python file named `download_openelm.py` in the root directory with the following content:

   ```python
   from huggingface_hub import snapshot_download

   # Specify the target directory for downloading the model
   target_directory = "models/hf_models/OpenELM-3B-Instruct"

   # Download a snapshot of the model repository
   snapshot_download(
       repo_id="apple/OpenELM-3B-Instruct",
       local_dir=target_directory,
       revision="main",  # Optional: specify a branch, tag, or commit hash
       local_dir_use_symlinks=False  # Set to True if you want symlinks instead of file copies
   )
   ```

2. Run the script to start downloading the model weights:

   ```bash
   python download_openelm.py
   ```

   > **Note:** The download may take around 20 minutes, depending on your internet speed, as the model is large (~3 billion parameters).

### Converting and Quantizing the Model

Once the model is downloaded, convert it to the GGUF format and quantize it for inference:

1. **Convert the model to GGUF format:**

   ```bash
   mkdir -p models/gguf_models

   python llama.cpp/convert_hf_to_gguf.py models/hf_models/OpenELM-3B-Instruct/ \
       --outfile models/gguf_models/OpenELM-3B-Instruct-f16.gguf \
       --outtype f16
   ```

2. **Quantize the model using llama-quantize:**

   The quantization process reduces the model's size and computational requirements, which can improve inference speed on resource-constrained devices like the Raspberry Pi. Two types of quantization are demonstrated here:
   
   - **Q8_0 Quantization:** This reduces the model to 8-bit precision, balancing model size and performance. It typically offers faster inference with a moderate impact on accuracy.
   - **Q4_0 Quantization:** This reduces the model further to 4-bit precision, providing greater speed and memory savings at the expense of some accuracy.

   For Q8_0 quantization:
   ```bash
   llama.cpp/build/bin/llama-quantize \
       models/gguf_models/OpenELM-3B-Instruct-f16.gguf \
       models/gguf_models/OpenELM-3B-Instruct-q8_0.gguf Q8_0
   ```

   For Q4_0 quantization:
   ```bash
   llama.cpp/build/bin/llama-quantize \
       models/gguf_models/OpenELM-3B-Instruct-f16.gguf \
       models/gguf_models/OpenELM-3B-Instruct-q4_0.gguf Q4_0
   ```

### Prompting the Model

After quantization, you can prompt the different models. For example, to use the Q8_0 quantized model:

```bash
llama.cpp/build/bin/llama-cli \
    -m models/gguf_models/OpenELM-3B-Instruct-q8_0.gguf \
    -p "Could you write a very simple program in C++ to print 'Hello, World!' in less than 10 lines of code?"
```

Follow similar steps for other prompts or to test the Q4_0 model. This setup process on the Raspberry Pi allows you to benchmark LLM inference on an edge device and later compare performance with an ARM Graviton server.
