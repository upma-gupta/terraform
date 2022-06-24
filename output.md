* Query output (-raw)
  * terraform output
  * terraform output lb_url
    * "http://lb-5YI-project-alpha-dev-2144336064.us-east-1.elb.amazonaws.com/"
  * terraform output -`raw` lb_url #Machine readable format
    * http://lb-5YI-project-alpha-dev-2144336064.us-east-1.elb.amazonaws.com/


* Redact sensitive output with `sensitive = true` attr


* Use terraform outp:ut to query the database password by name, and notice that Terraform will not redact the value when you specify the output by name. 


* Generate machine-readable output

    * $ terraform output -json