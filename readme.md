#Infrastructore as code with terraform

# what is terraform

there are 2 sides of IAC
- 1: configuration management
- 2: Orchestration

Ansible -Configuration management
Terraform - Orchestration 
Kubernetes - orchestration is used in containerisation - docker, crio, rocket

Terraform
- Terraform files are created with .tf

-commands
    terraform init - initialises terraform in your project directory 
    terraform plan - checks the steps inside the code and lists success or errors 
    terraform apply - runs the main.tf filer 
    
    
    
    
# How to create EC2 instance using AMI image and Terraform - WINDOWS

- Download Terraform ![](https://www.terraform.io/downloads.html)

- Once downloaded, extract the folder to where you want the Terraform.exe

- Run it as admin

- Now you need to set the PATH environment variable 


![](Images/Image1.png)

Open your setting 








![](Images/image2.png)

Once in setting, type into the search box, "advanced setting" and click on the View advanced system settings





![](Images/image3.png)

Once here click on Environment Variables

![](Images/Image4.png)


Once inside, scroll to your path variable and double click on it 

![](Images/Image5.png)

Add the folder URL to the environment variable

![](Images/Image6.png)


Once this is done, exit out of the settings and open up your git bash, 

type in - terraform --version - to check if terraform has been installed correctly


You have now set your PATH variable, you can now create with Terraform 