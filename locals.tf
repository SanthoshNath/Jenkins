locals {
  myIP = "${chomp(data.http.my_IP.response_body)}/32"
}
