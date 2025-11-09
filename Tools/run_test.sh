> test_out.txt
num_runs=5 #change these to adjust the test
other_AI=Sample_AIs/Random_AI/main.py #change these to adjust the test

for (( i=1; i<=$num_runs; i++ )) do
  python3 AI_Runner.py 5 5 2 l ../src/checkers-python/main.py $other_AI
done

wins_student=$(grep -o -i "player 1" test_out.txt | wc -l)
wins_other=$(grep -o -i "player 2" test_out.txt | wc -l)
ties=$(grep -o -i "Tie" test_out.txt | wc -l)

> test_out.txt #reset output file to run other parity
for (( i=1; i<=$num_runs; i++ )) do
  python3 AI_Runner.py 5 5 2 l $other_AI ../src/checkers-python/main.py 
done

wins_student=$(($wins_student + $(grep -o -i "player 2" test_out.txt | wc -l)))
wins_other=$(($wins_other + $(grep -o -i "player 1" test_out.txt | wc -l)))
ties=$(($ties + $(grep -o -i "Tie" test_out.txt | wc -l)))

echo Student AI:$wins_student
echo Other AI:$wins_other
echo Ties:$ties
success=$(($wins_student + $ties))
games=$(($wins_student + $wins_other + $ties))
echo Winrate: $(echo "scale=3; $success / $games" | bc)
