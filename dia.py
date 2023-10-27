from diagrams import Diagram
from diagrams.aws.compute import EC2
from diagrams.aws.network import ELB

with Diagram("Application Architecture", show=False):
    ELB("Load Balancer") >> EC2("Docker Container")
