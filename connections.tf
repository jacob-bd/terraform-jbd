provider "google" {
  credentials = "${file("../account.json")}"
  project     = "terraform-jbd"
  region      = "us-east1"
}

provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}

resource "azurerm_resource_group" "tf-rg" {
  location = "East US"
  name     = "my-tf-rg"
}

resource "azurerm_virtual_network" "ft-vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  name                = "my-tf-vnet"
  resource_group_name = "${azurerm_resource_group.tf-rg.name}"
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  tags {
    environment = "ft-tests"
  }
}
