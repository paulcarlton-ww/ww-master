#!/usr/bin/env python3
from google.cloud import storage


def download_public_file(bucket_name, source_blob_name, destination_file_name):
    """Downloads a public blob from the bucket."""

    storage_client = storage.Client.create_anonymous_client()

    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)

    print(
        "Downloaded public blob {} from bucket {} to {}.".format(
            source_blob_name, bucket.name, destination_file_name
        )
    )


bucket_name = "tekton-releases"
source_blob_name = "pipeline/previous/v0.36.0/release.yaml"
destination_file_name = "test.yaml"
download_public_file(bucket_name, source_blob_name, destination_file_name)