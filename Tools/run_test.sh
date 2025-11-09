> test_out.txt
for num in {1..100}; do
  python3 AI_Runner.py 8 8 2 l ../src/checkers-python/main.py Sample_AIs/Random_AI/main.py
done

wins1=$(grep -o -i "player 1" test_out.txt | wc -l)
wins2=$(grep -o -i "player 2" test_out.txt | wc -l)

echo Player 1:$wins1
echo Player 2:$wins2
games=$((wins1 + wins2))
echo Winrate: $(echo "scale=3; $wins1 / $games" | bc)
