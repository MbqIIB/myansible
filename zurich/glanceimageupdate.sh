#!/bin/bash

imageid=92f751f9-5871-44ba-91a8-af7cf03ba84
glance image-update --property image_type=custom_image --visibility=public ${imageid}
