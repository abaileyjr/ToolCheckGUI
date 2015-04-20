        function [student, mentor, staff, school, purch, purchnum, tool, toolquant] = data() 
            staff = {}; %Sheet 1
            mentor = {}; % Sheet 2
            student = {}; % Sheet 3
            school = {}; % Sheet4
            purch = {}; % Sheet 5
            tool = {}; % Sheet 6
            
            % Creates empty cells, may not be needed
            
            [~, staff, ~] = xlsread('Database','Staff');
            [~, mentor, ~] = xlsread('Database','Mentor');
            [~, student, ~] = xlsread('Database','Student');
            [~, school, ~] = xlsread('Database','School');
            [purchnum,purch, ~] = xlsread('Database','Purchase');
            [toolquant,tool,~] = xlsread('Database','Tool');
            
            % Reads the database xls file and stores the data in the
            % respective student, ,mentor, staff, school, and purchasabel 
            % arrays.
        end
