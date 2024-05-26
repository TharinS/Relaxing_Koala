#!/bin/bash

# Clear previous output file if it exists
> analytics_test_output.txt

# Most Popular Item
echo "Testing most_popular endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/most_popular >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# Least Popular Item
echo "Testing least_popular endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/least_popular >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# Top 10 Items
echo "Testing top_10 endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/top_10 >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# Bottom 10 Items
echo "Testing bottom_10 endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/bottom_10 >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# All Items Descending
echo "Testing all_descending endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/all_descending >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# All Items Ascending
echo "Testing all_ascending endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/all_ascending >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt

# Random Recommendation
echo "Testing random_recommendation endpoint" >> analytics_test_output.txt
curl -X GET http://127.0.0.1:5000/analytics/random_recommendation >> analytics_test_output.txt
echo -e "\n" >> analytics_test_output.txt
