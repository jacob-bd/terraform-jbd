resource "google_compute_network" "gcp_network" {
  name                    = "mynet"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gcp-subnet" {
  ip_cidr_range = "10.0.1.0/24"
  name          = "tf-gcp-subnet"
  network       = "${google_compute_network.gcp_network.self_link}"
  region        = "us-east1"
}

resource "aws_vpc" "tf-created-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = "${aws_vpc.tf-created-vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.tf-created-vpc.cidr_block, 3, 1)}"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = "${aws_vpc.tf-created-vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.tf-created-vpc.cidr_block, 2, 2)}"
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "tf-security_group" {
  name   = "test-tf-vpc"
  vpc_id = "${aws_vpc.tf-created-vpc.id}"

  ingress {
    cidr_blocks = [
      "${aws_vpc.tf-created-vpc.cidr_block}",
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
}
