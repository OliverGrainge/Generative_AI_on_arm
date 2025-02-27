# **Generative AI on ARM**

Welcome to the **Generative AI on ARM** course! This course is designed to help you master the optimization of generative AI workloads on ARM architectures through hands-on labs. There are three labs available:

- **Lab 1**: Focuses on mobile devices, such as the Raspberry Pi 5.
- **Lab 2**: Designed for ARM-based servers, such as AWS Graviton instances.
- **Lab 3**: Compares the challenges and comparisons between Cloud based and Edge based deployment.

In each lab, you will learn to optimize AI inference using ARM-specific intrinsics and techniques to achieve efficient performance.

---

## **Getting Started**

### **Lab 1: Optimizing Generative AI on Raspberry Pi**

1. **Run the setup script**  
   Open a terminal in the project directory and execute the setup script:  
   ```bash
   ./setup.sh
   ```

2. **Open the course material**  
   The course material is provided as Jupyter notebooks. To access the content:
   ```bash
   source pi5_env/bin/activate
   jupyter lab
   ```

3. Follow the instructions provided in the notebooks to complete the lab.

---

### **Lab 2: Optimizing Generative AI on ARM Servers**

1. **Launch an AWS EC2 instance**  
   - Go to Amazon EC2 and create a new instance.
   - **Select key pair**: Create a key for SSH connection (e.g., `yourkey.pem`).
   - **Choose an AMI**: Use the `Ubuntu 24.04` AMI as the operating system.
   - **Instance type**: Select `m7g.xlarge` (Graviton-based instance with ARM Neoverse cores).
   - **Storage**: Add 64 GB of root storage.

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
   Copy the link provided in the terminal output, open it in your browser, and follow the instructions in the notebooks.

---

## **Additional Notes**

- Ensure that you have the necessary permissions to launch AWS instances and SSH into them.
- The labs require an active internet connection for downloading models and dependencies.
- For Lab 2, make sure to terminate the EC2 instance when you're done to avoid unnecessary charges.

---

Happy learning!


