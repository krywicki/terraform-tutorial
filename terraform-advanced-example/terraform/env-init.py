#
# This script creates soft linked files to common assets shared by all
#   terraform environments. The goal should be to only ever modify a terraform.tfvars file, not
#   have to modify every main.tf file or variables.tf file in every environment
#

import os
import sys

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
ENV_DIR = sys.argv[1]
ENV_COMMON_DIR = os.path.join(SCRIPT_DIR, "envs-common")

# relative path from ENV_DIR to
REL_PATH_COMMON_DIR = os.path.join(
    os.path.relpath(SCRIPT_DIR, ENV_DIR), ENV_COMMON_DIR)

# change working dir to ENV_DIR
os.chdir(ENV_DIR)

# for all dir items in ENV_COMMON_DIR relative symlink in ENV_DIR
for item in os.listdir(ENV_COMMON_DIR):
    item_path = os.path.join(ENV_COMMON_DIR, item)

    os.symlink(os.path.join(REL_PATH_COMMON_DIR, item),
               item, os.path.isdir(item_path))
