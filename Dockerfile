FROM alpine

RUN apk update
RUN apk add --no-cache fio

RUN fio \
    --randrepeat=1 \
    --ioengine=libaio \
    --direct=1 \
    --gtod_reduce=1 \
    --name=test \
    --filename=/home/random_read_write.fio \
    --bs=4k \
    --iodepth=64 \
    --size=1G \
    --readwrite=randrw \
    --rwmixread=75

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
