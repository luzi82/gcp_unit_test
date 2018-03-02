import argparse
import traceback
import sys

TEST_LIST = []

def import_gcs():
    # in 20180302, GCP ML Engine say import err in google.cloud.storage
    import google.cloud.storage


TEST_LIST.append(import_gcs)

def ttry(func):
    try:
        func()
        return True
    except:
        traceback.print_exc()
    return False

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--job-dir', type=str)
    parse_args = parser.parse_args()

    good = True
    
    for ttest in TEST_LIST:
        good = ttry(ttest) and good
    
    if not good:
        sys.exit(1)
    