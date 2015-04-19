        function [student, mentor, staff, school] = data() 
            staff = {}; %Sheet 1
            mentor = {}; % Sheet 2
            student = {}; % Sheet 3
            school = {}; % Sheet4
            
            % Creates empty cells, may not be needed
            
            [~, staff, ~] = xlsread('Database','Staff');
            [~, mentor, ~] = xlsread('Database','Mentor');
            [~, student, ~] = xlsread('Database','Student');
            [~, school, ~] = xlsread('Database','School');
            
            % Reads the database xls file and stores the data in the
            % respective student, ,mentor, staff, and school arrays.
        end
