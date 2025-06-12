# **Generative AI on ARM**

Welcome to **Generative AI on ARM**, a hands-on course designed to help you optimize generative AI workloads on ARM architectures. Through practical labs and structured lectures, you will learn how to deploy AI models efficiently across different ARM-based environments.

## Course Structure

This course consists of three hands-on labs and four lectures.

### Hands-On Labs
- **Lab 1**: Optimizing generative AI on mobile devices, such as the Raspberry Pi 5.
- **Lab 2**: Deploying AI workloads on ARM-based cloud servers, including AWS Graviton.
- **Lab 3**: Comparing cloud vs. edge inference, analyzing challenges and trade-offs.

### Lecture Series
Inside the `slides/` folder, you will find four lectures covering the key concepts and challenges in AI inference on ARM:

1. **Challenges Facing Cloud and Edge GenAI Inference** – Understanding the limitations and constraints of AI inference in different environments.
2. **Generative AI Models** – Exploring model architectures, training methodologies, and deployment considerations.
3. **ML Frameworks and Optimized Libraries** – A deep dive into AI software stacks, including PyTorch, ONNX Runtime, and ARM-specific optimizations.
4. **Optimization for CPU Inference** – Techniques such as quantization, pruning, and leveraging SIMD instructions for faster AI performance.

## What You'll Learn

You will learn how to optimize AI inference using ARM-specific techniques such as SIMD (SVE, NEON) and low-bit quantization. The course covers practical strategies for running generative AI efficiently on mobile, edge, and cloud-based ARM platforms. You will also explore the trade-offs between cloud and edge deployment, gaining both theoretical knowledge and hands-on skills.

By the end of this course, you will have a strong foundation in deploying high-performance AI models on ARM hardware.


---

## **Getting Started**

### **Lab 1: Optimizing Generative AI on Raspberry Pi**

1. **Run the setup script**  
   Open a terminal in the project directory and execute the setup script:  
   ```bash
   ./setup.sh
   ```
2. **Login to a Hugging face account**
   ```bash
   huggingface-cli login
   ```
3. **Open the course material**  
   The course material is provided as Jupyter notebooks. To access the content:
   ```bash
   source pi5_env/bin/activate
   jupyter lab
   ```

4. Follow the instructions provided in `lab1.ipynb` to complete the lab.

---

### **Lab 2: Optimizing Generative AI on ARM Servers**

1. **Launch an AWS EC2 instance**  
   - Go to Amazon EC2 and create a new instance.
   - **Select key pair**: Create a key for SSH connection (e.g., `yourkey.pem`).
   - **Choose an AMI**: Use the `Ubuntu 22.04` AMI as the operating system.
   - **Instance type**: Select `m7g.2xlarge` (Graviton-based instance with ARM Neoverse cores).
   - **Storage**: Add 32 GB of root storage.

2. **Connect to the instance via SSH**  
   Use the following command to establish an SSH connection (replace with your instance details):
   ```bash
   ssh -i "yourkey.pem" -L 8888:localhost:8888 ubuntu@<ec2-public-dns>
   ```

3. **Clone the repository**  
   Once connected to the instance, clone the repository:
   ```bash
   git clone https://github.com/OliverGrainge/Generative_AI_on_arm.git
   ```

4. **Run the setup script**  
   Change to the repository directory and run the setup script:
   ```bash
   cd Generative_AI_on_arm
   ./setup_graviton.sh
   ```

5. **Activate the virtual environment and log in to Hugging Face**  
   After the setup completes, activate the virtual environment:
   ```bash
   source graviton_env/bin/activate
   huggingface-cli login
   ```
   (You will need to log in to Hugging Face to download the required large language model.)

6. **Launch the lab**  
   Start Jupyter Lab by running:
   ```bash
   jupyter lab
   ```
   Copy the link provided in the terminal output, open it in your local browser, and follow the instructions in the notebooks.

---

### **Lab 3: Comparative Inference Benchmarking on ARM Server and Edge Devices**

1. Follow the setup stpes for `lab1` on your local raspberry pi.
2. Follow the setup stpes for `lab2` on your raspberry pi, to create and connect to a cloud instance.
3. Open `lab3.ipynb` to find the instructions for completing the lab 

---

## **Additional Notes**
- To complete this course you are required to have access to a Raspberry Pi-5, for the cloud sections, AWS can be utilised. 
- For Lab 2 and 3 make sure to terminate the EC2 instance when you're done to avoid unnecessary charges.

**Happy learning!**


