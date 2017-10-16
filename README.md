This is a simple upload tool for Amazon S3 using the AWS SDK for Go

Usage of ./s3uploader [options] filename:
  -bucket string
        s3 bucket to upload to (default "my-s3-bucket")
  -keyname string
        key of the file that is uploaded (default "file.txt")
  -region string
        aws region (default "eu-central-1")