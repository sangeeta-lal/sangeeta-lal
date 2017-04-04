#!/bin/bash

if [ $# -ne 2 ]
then 
    echo "Usage: run_mallet.sh input-dir output-dir"
    exit
fi

input_dir=$1
output_dir=$2

echo $input_dir
echo $output_dir

mallet import-dir \
    --input $input_dir \
    --output $output_dir/source_code.sequences \
    --keep-sequence \
    --gram-sizes 1,2


mallet train-topics \
    --input $output_dir/source_code.sequences \
    --num-topics 500 \
    --alpha 50.0 \
    --beta 0.01 \
    --num-iterations 10000 \
    --optimize-burn-in 1000 \
    --optimize-interval 100 \
    --num-threads 4 \
    --random-seed 1 \
    --show-topics-interval 500 \
    --output-model $output_dir/topic.model \
    --output-state $output_dir/topic-state.gz \
    --output-topic-keys $output_dir/topic_keys.dat \
    --output-doc-topics $output_dir/doc_topics.dat \
    --topic-word-weights-file $output_dir/topic_word_weights_file.dat \
    --diagnostics-file $output_dir/diagnostics.xml \
    --word-topic-counts-file $output_dir/word_topic_counts.dat \
    --xml-topic-phrase-report $output_dir/topic_phrase_report.xml \
    --inferencer-filename $output_dir/inferencer.mallet \
    --evaluator-filename $output_dir/evaluator.mallet \
