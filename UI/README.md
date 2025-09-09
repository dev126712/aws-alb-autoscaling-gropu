# Scalable Wev App with ALB & Auto Scaling

## This project involves deploying a highly available web application using Amazon EC2, Application Load Balancer (ALB), and Auto Scaling. The goal is to ensure that the web app can scale automatically based on traffic demand while maintaining availability.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9ae2caab39175ec774cb2922811ea928f05ebac0/Screenshot%202025-09-02%2019.46.25.png)

### VPC and more

#### I first created this project VPC named 'test-vpc' using 'VPC and more'. This feature allows the creation of public and private subnets, internet gateway, NAT Gateway, route table and security groups.

#### In my case I created my VPC with an IPV4 CIDR block of 10.0.0.0/16, in 2 Avaibility Zones with 2 public subnets and no private subnets, no NAT gateway and no VPC endpoints.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d0416b18a3e0e4b2a224435242efc8dffbcd6f54/vpc1.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d0416b18a3e0e4b2a224435242efc8dffbcd6f54/vpc2.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/bd2d4ea286a4ad21da6d0f4392fd38177d28dd0f/vpc3.png)

### Target group

#### I then created the target group names 'test-tg' wich route request to one or more target type from a load balancer and in my case it's to my Instances that I'm going to create and deploy in my Launche templatle. I choose the taget group protocol to be http on port 80 in the project because it's the sompliest and most direct way to demonstrate the load balancer fonctionality. In a real world I would have select https protocol because it's the secure encrypted version of http.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/29334139fbcbfdbf7b0e839de53682c067d74af8/tg1.png)

#### I then had to specify wich vpc with the instances that i want to include in the target group.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/29334139fbcbfdbf7b0e839de53682c067d74af8/tg2.png)

#### After created the target group it shows that i dont have no register target yet because i didn't created the instance where I'm going to route traffic.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/29334139fbcbfdbf7b0e839de53682c067d74af8/tg3.png)

### Load Balancer

#### After the target group I created the load balancer wich it's going to route traffic to the target group.

#### I choose the Application Load Balancer (ALB) wich is the standard choice for most modern web app.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9cca45240e302dbdb9192466ea911b6f90a7f9ea/alb1.png)

#### I named my load balancer 'test-alb' and selected Internet-facing because I want it to handle http request from the public internet

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9cca45240e302dbdb9192466ea911b6f90a7f9ea/alb2.png)

#### I had to select the project vpc 'test-vpc' where it will exist and scale.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9cca45240e302dbdb9192466ea911b6f90a7f9ea/alb3.png)

#### I also created a new security group that going to allows http request from anywhere on the internet '0.0.0.0/0' and attach it to the load balancer

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9cca45240e302dbdb9192466ea911b6f90a7f9ea/alb-sg.png)

### After selected the new security groups that allows http request, I select the listener to protocol HTTP on port 80. Meaning that it determinehow the load balancer route request to its target(s) wich is the target group that I created earlier.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/9cca45240e302dbdb9192466ea911b6f90a7f9ea/alb4.png)


### Auto Scaling Group

#### Last i need to create the auto scalling group wich is uses to maintaining the number of instances in an Auto Scaling group and automaticate its scaling. For the project I name the scaling group 'test' and I configure the ec2 instance with a launch template. 

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg.png)

#### My launch template 'test-temp' is like a set of instrucion that the Auto Scalling Group have to follows every time its want to create a new ec2 instance. I confifigure it to use the Amazon Linuz AMI with the free tier Image and Instance type
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg2.png)

#### I created a new security group also that is attached to every instance that being created by the auto scaling group. The rules allows http on port 80 to allows http request traffic and ssh on port 22 so that i can access the ec2 remotly if needed.
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg4.png)

#### The security group

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg3.png)

#### I selected enable auto-assign public ip wich going to assign a public ip addresse to every ressources in that template and let everything else on default.
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg5.png)

#### Last I created an User data script that first update the repo package. Second, install, start and enable Nginix. Third, created an HTML (index.html) file in the /usr/share/ngnix/html/ path that going to display the private ip address of the instance. That script is going to run on every instance created by the Auto Scalling Group so that i don't have to do it manually. That all for the Launch template configuration
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/lt-asg6.png)

#### Back to the Auto Scalling configuration. First I had to define wich VPC and subnets my ressources are going to be deployed. 

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg2.png)

#### Second I selected 'Attach to an existing load balancer' and choose the load balancer target group that I created earlier.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg3.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg4.png)

#### For the scalling policy I set the desired capacity to be 3, minimum desired capacity to be 1 and max desired capacity to be 5. That mean by default it should have 3 instance and on high traffic set the maximum instance to 5.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg5.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg6.png)

#### For the project I keep it simple and had no notifications and no tags. 

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg7.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/7f7c8d62b3bac989a5d27fa2995da6c0eee7eff1/asg8.png)


### Verification

#### Now that everything is set up, to check if the load balancer its working i navigate to its DNS name on http.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d401478a6c914b1c96b7392541675b59315bc81d/ver.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d401478a6c914b1c96b7392541675b59315bc81d/ver1.png)

#### The load balancer is wroking proprely I can see the html page that I set up earlier on the user data. I can see it direct traffic on the 3 instance that was deploye by the auto scaling group.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d401478a6c914b1c96b7392541675b59315bc81d/ver2.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d401478a6c914b1c96b7392541675b59315bc81d/ver3.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d401478a6c914b1c96b7392541675b59315bc81d/ver4.png)

#### I also can see the three instance that i speficy that should be running by default on the launch template.

#### You can check with the prevate ip of the 3 instance that running.

![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d2c996ab45b82e72064260fb62ed7d5598117c13/ver5.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d2c996ab45b82e72064260fb62ed7d5598117c13/ver6.png)
![Image](https://github.com/dev126712/alb-autoScalingGroup/blob/d2c996ab45b82e72064260fb62ed7d5598117c13/ver7.png)

### Auto Scalling Verifications




