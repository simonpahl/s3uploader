package main

import (
	"flag"
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
	"os"
)

func main() {

	regionFlag := flag.String("region", "eu-central-1", "aws region")
	bucketFlag := flag.String("bucket", "my-s3-bucket", "s3 bucket to upload to")
	keynameFlag := flag.String("keyname", "file.txt", "key of the file that is uploaded")
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, "Usage of %s [options] filename:\n", os.Args[0])
        flag.PrintDefaults()
	}

	flag.Parse()

	bucket := *bucketFlag
	region := *regionFlag
	keyname := *keynameFlag
	filename := flag.Arg(0)

	fmt.Println("Using options:")	
	fmt.Println("region:", region)
	fmt.Println("bucket:", bucket)
	fmt.Println("key:", keyname)
	fmt.Println("filename:", filename)

	//creds := credentials.NewChainCredentials([]credentials.Provider{
	//	&credentials.EnvProvider{},
	//	&credentials.SharedCredentialsProvider{},
	//})

	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(region),
	}))
	// Create an uploader with the session and default options
	uploader := s3manager.NewUploader(sess)

	f, err := os.Open(filename)
	if err != nil {
		fmt.Printf("failed to open file %q, %v\n", filename, err)
		os.Exit(1)
	}

	// Upload the file to S3.
	result, err := uploader.Upload(&s3manager.UploadInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(keyname),
		Body:   f,
	})
	if err != nil {
		fmt.Printf("failed to upload file, %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("file uploaded to, %s\n", aws.StringValue(&result.Location))

}
