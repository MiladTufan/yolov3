from utils.general import create_train_test_split_txt
import argparse


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--src", type=str, default="", help="path to image folder")
    parser.add_argument("--dest", type=str, default="", help="Path to where train and test txt should be place to")
    
    args = parser.parse_args()
    create_train_test_split_txt(args.src, args.dest)