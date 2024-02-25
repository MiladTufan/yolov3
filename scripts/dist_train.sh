
#!/usr/bin/env bash

set -x
NGPUS=$1
PY_ARGS=${@:2}

while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT
#CUDA_VISIBLE_DEVICES=0,1,2,3 
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Executing training from $SCRIPT_DIR/../train.py"
echo "Number of gpus is ${NGPUS}"
python -m torch.distributed.run --nproc_per_node=${NGPUS} --master_port=${PORT} $SCRIPT_DIR/../train.py --batch 8 --data kitti.yaml --weights yolov3.pt --device 0
