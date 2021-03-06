## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](Diagrams/NWDIG.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml file may be used to install only certain pieces of it, such as Filebeat.

- **[install-elk.yml](Ansible/install-elk.yml)**
- **[filebeat-playbook.yml](Ansible/filebeat-playbook.yml)**
- **[metricbeat-playbook.yml](Ansible/metricbeat-playbook.yml)**

This document contains the following details:

- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly `available`, in addition to restricting `access` to the network.
>- _**Load balancing** is the process of distributing incoming reequests/tasks over a set of resources in order to prevent disproportionate skew of requests load towards one specific server. For example, this can be particularly useful in maintaining availability of services to customers in the setting of a DoS attack on one of the server, rendering it unavailable. If the same services are available on an alternate server, the load balancer can distribute the web traffic to the alternate server when the primary server is 'overloaded' - this way the services (such as sales) continue to remain operational even in the mist of the attack. In addition it can also be configured to limit access to particular servers to prevent penetration by hackers._

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the `logs` and `system metrics`.
>- _**Filebeat** collects data about the file system. It is helpful in detecting changes to certain important files stampd by time like for example if a hacker attemps to change etc/passwd and this information is then sent to Elasticsearch on the ELK Server_
>- _**Metricbeat** Collects metrics to help with the assessment regarding the operational state of computer machines on the network (VMs in this case) and then sends it to Elasticsearch on ELK Server. For example it can be helpful in determining CPU usage, memory disk I/O, Network I/O and Uptime information_

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box | Gateway  | 10.0.0.7   | Linux            |
| Web-1    | Webserver| 10.0.0.8   | Linux            |
| Web-2    | Webserver| 10.0.0.9   | Linux            |
| ELK      |Monitoring| 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the *Jump-Box* machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _*Source IP = public ip of your laptop*_
- _*Destination IP = 10.0.0.4*_
- _*Service = ssh*_
- _*Action = Allow*_

Machines within the network can only be accessed by *Jump-Box*.
- _Only the Jump-Box can connect to Web-1, Web-2, ELK and its IP is 10.0.0.7_

A summary of the access policies in place can be found in the table below.

-**RedTeam_NSG**
| Name                  | Publicly Accessible  | Allowed IP Addresses| Notes         |
|-----------------------|----------------------|---------------------|---------------|
| Allow_SSH_from_laptop | Yes                  | azdmin's Public IP  |               |
| Allow_TCP_to_VN       | Yes, TCP to Web-1,2  | azdmin's Public IP  |               |
| SSH_from_jumpbox      | No, Via Jump-Box     | 10.0.0.1-254        |               |

-**Elk-server-NSG**
| Name                  | Publicly Accessible  | Allowed IP Addresses| Notes         |
|-----------------------|----------------------|---------------------|---------------|
| elk_tcp_5601          | Yes, TCP to port 5601| azdmin's Public IP  |               |
| SSH                   | No, via Jump-Box     | 10.0.0.1-254        |               |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because:
>- _It simplifies the process of configuring additional machines or updating changes to all existing ones to the network simultaneously. We will only have to make changes to the ansible playbook and it will automatically be implemented to all the machines linked with the playbook. Alternatively if we do not use the playbook then we will have to make configuration changes to all of the machines individually which can be cumbersome and error prone_

The playbook implements the following tasks:
- _Installs Docker, which intern facilitates instalation of containers._
- _Installs Python-pip_
- _Installs Docker python module_
- _Increases Virtual Memory_
- _Downloads and launches a docker ELK container with the ports `5601`, `9200`, `5044`_

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker ps](Diagrams/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines on which `filebeat` and `metricbeat` are installed:
- _Web-1_
- _Web-2_


We have installed the following Beats on these machines:
- _`filebeat`_
- _`metricbeat`_

These Beats allow us to collect the following information from each machine:

>- _**Filebeat** collects data about the file system. Helpful in detecting changes to certain important files stampd by time like for example if a hacker attemps to chenge etc/passwd and this information is then sent to Elasticsearch on the ELK Server_

>- _**Metcicbeat** Collects metrics to help with the assessment about the operational state of computer machines on the network (VMs in this case) and then sends it to Elasticsearch on ELK For example it can be helpful in determining CPU usage, memory sisk IO, Network UO and Uptime information._


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the `install-elk.yml` file to `/etc/ansible/files/`
- Update the `/etc/ansible/hosts` file to include `elk server IP address 10.1.0.4`
- Run the playbook, and navigate to `http://[Elk_VM_Public_IP]:5601/app/kibana` to check that the installation worked as expected.

_Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
  - The playbook file is `/etc/ansible/files/filebeat-config.yml` and its copied in `/etc/ansible/files/`
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
  - Updating the `filebeat-config.yml` specify which machine to install by updating host files with IP addresses of webserver/elk server and selecting which group to run in in asnsible
- _Which URL do you navigate to in order to check that the ELK server is running?
  - The ELK server URL is `http://<VM public IP>:5601/app/kibana`

