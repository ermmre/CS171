from random import randint
from BoardClasses import Move
from BoardClasses import Board
import copy
import random
#The following part should be completed by students.
#Students can modify anything except the class name and exisiting functions and varibles.
class StudentAI():

    def __init__(self,col,row,p):
        self.col = col
        self.row = row
        self.p = p
        self.board = Board(col,row,p)
        self.board.initialize_game()
        self.color = ''
        self.opponent = {1:2,2:1}
        self.color = 2

    def monte_carlo(self, board, color, sims=30):
        moves = []
        for group in board.get_all_possible_moves(color):
            for m in group:
                moves.append(m)

        best_move = None
        best_score = -1

        for move in moves:
            wins = 0
            for _ in range(sims):
                board_copy = copy.deepcopy(board)
                board_copy.make_move(move, color)
                winner = self.rollout(board_copy, self.opponent[color])
                if winner == color:
                    wins += 1
                elif winner == 0:
                    wins += 0.5
            score = wins / sims
            if score > best_score:
                best_score = score
                best_move = move
        
        return best_move

    def rollout(self, board, current_player):
        while not board.is_win(1) and not board.is_win(2):
            moves = board.get_all_possible_moves(current_player)
            if not moves:
                return 0
            move = random.choice(random.choice(moves))
            board.make_move(move, current_player)
            current_player = self.opponent[current_player]

        if board.is_win(1):
            return 1
        elif board.is_win(2):
            return 2
        return 0

    def get_move(self,move):
        if move:
            self.board.make_move(move, self.opponent[self.color])
        else:
            self.color = 1

        best_move = self.monte_carlo(self.board, self.color, sims=30)
        self.board.make_move(best_move, self.color)
        return best_move
