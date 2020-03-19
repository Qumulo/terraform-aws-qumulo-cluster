[![Qumulo Logo](https://qumulo.com/wp-content/uploads/2019/03/Q-logo-onwhite.png)](http://qumulo.com)

# terraform-aws-qumulo-cluster ![Build Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiSFdqMnlNRys1OEdDY3I5Y0tKLzdNRUtuZjNEY1NJbWNRSEk0eEdsYzNkc3dRcm1qR3BkaFpacWF2cy9sVjJHZXRpY1dFWS9GdXRZdFJ4K0lkVE1vZTJrPSIsIml2UGFyYW1ldGVyU3BlYyI6InF3TVg2UmY2d2JJYWJjbE4iLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

Terraform Module which creates a Qumulo Cloud Cluster in AWS.

This is primarily meant to help in spinning up clusters and provides an alternate method to CloudFormation.

## Requirements

This module requires the [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws) `>= 2.53`

It also requires the AMI ID of the [Qumulo Cloud Software](https://qumulo.com/product/cloud-products/).
You can find AMIs for the Qumulo Cloud Software on the [AWS Marketplace](https://aws.amazon.com/marketplace/search/results?page=1&filters=VendorId&VendorId=c35cf4f2-2f03-462f-9548-27863b37e609&searchTerms=Qumulo) =
or by [Contacting Qumulo Sales](http://discover.qumulo.com/cloud-calc-contact.html).

## Usage


**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to a release tag (e.g. `?ref=tags/x.y.z`).

```hcl
module "qumulo_cluster" {
  source            = "git::https://github.com/Qumulo/terraform-aws-qumulo-cluster.git?ref=master"
  ami_id            = "ami-0641894224608b956"  # us-west-2 Qumulo-Cloud-3.0.0.2-release-5tib
  cluster_name      = "QumuloFileCluster"
  instance_type     = "m5.8xlarge"
  node_count        = 4
  key_pair_name     = "admin_ssh_key"
  subnet_id         = "subnet-abcdef"
  secutiy_group_ids = ["sg-1234567"]
  tags              = {
    User = "jdoe"
    Department = "IT"
  }
}
```

__NOTE:__ This module does not support input values changing while preserving
data on the cluster. It is designed to ease launching and terminating whole
clusters at once, not to make changes to active clusters. Data loss will occur
on a deployed cluster if a plan apply recreates any of the nodes managed by the
module.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami_id | The AMI ID for the Qumulo Cloud Software you wish to deploy | string | - | yes |
| cluster_name | What to name the cluster | string | - | yes |
| instance_type | Desired EC2 Instance Type. | string | m5.8xlarge | no |
| key_pair_name | EC2 SSH key pair to ssh to the "admin" user | string | - | yes |
| node_count | Number of Nodes (min: 4, max: 100) | number | 4 | no |
| subnet_id | ID of VPC subnet you want to spawn the cluster in | string | - | yes |
| security_group_ids | List of security groups you want to attach to nodes | list(string) | - | yes |
| tags | Additional tags to add to instances | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | Ec2 instance ids of all nodes |
| private_ips | List of all private IPs for all nodes in cluster |
| public_ips | List of all public IPs for all nodes in cluster (this can be empty if your VPC setting is not to assign public IPs) |
| temp_admin_password | Password used to authenticate as admin on the WebUI |

## Help

File a GitHub [issue](https://github.com/Qumulo/terraform-aws-qumulo-cluster//issues) is the recommended way.

__Note:__ This project is provided as a public service to the AWS/Terraform
community and not directly supported by Qumulo's paid enterprise support. It is
intended to be used by expert users only.

## Copyright

Copyright © 2020 [Qumulo, Inc.](https://qumulo.com)

## License

[![License](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)

See [LICENSE](LICENSE) for full details

    MIT License
    
    Copyright (c) 2020 Qumulo
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

### Contributors

 - [dmotles](https://github.com/dmotles)
