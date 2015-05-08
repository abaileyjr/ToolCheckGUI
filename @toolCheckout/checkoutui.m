function checkoutui(cOut)
%CHECKOUTUI This function runes the GUI for the toolCheckout project. This
%function also directly interfaces with the spradsheet and a toolCheckout
%object.

%Initializing the Main Page
toolWasPressed = 0;
purchaseWasPressed = 0;
mainscreen = figure('Name','Main Screen');
pos = get(mainscreen,'Position');
set(mainscreen,'Position',[pos(1:2),400,400]);
toolpurchPanel = uipanel('Parent',mainscreen,'Position',[0,.3,1,1]);
addPanel = uipanel('Parent',mainscreen,'Position',[0,0,1,.3]);
orText = uicontrol(mainscreen,'Style','text',...
                        'String','-OR-',...
                        'FontSize',20,...
                        'Units','normalized',...
                        'Position',[.4,.27,.2,.08]);

% The person's status/title: Student/Mentor
statusText = uicontrol(toolpurchPanel,'Style','text',...
                        'FontSize',12,...
                        'String','Status',...
                        'Units','normalized',...
                        'Position',[.25,.56,.5,.1]);
statusPopup = uicontrol(toolpurchPanel,'Style','popup',...
                        'String',{'Student','Mentor'},...
                        'Units','normalized',...
                        'FontSize',10,...   
                        'Position',[.25,.53,.5,.08]);

% The person's name
personText = uicontrol(toolpurchPanel,'Style','text',...
                        'FontSize',12,...
                        'String','Name',...
                        'Units','normalized',...
                        'Position',[.25,.4,.5,.1]);
personEdit = uicontrol(toolpurchPanel,'Style','edit',...
                        'Units','normalized',...
                        'FontSize',10,...
                        'Position',[.25,.37,.5,.08]);
                    
% Tool button
toolButton = uicontrol(toolpurchPanel,'Style','pushbutton',...
                        'Units','normalized',...
                        'FontSize',20,...
                        'String','Tool',...
                        'Position',[.1,.07,.35,.22],...
                        'Callback',{@tool_callback});

% Purchase button
purchaseButton = uicontrol(toolpurchPanel,'Style','pushbutton',...
                        'Units','normalized',...
                        'FontSize',20,...
                        'String','Purchase',...
                        'Position',[.55,.07,.35,.22],...
                        'Callback',{@purchase_callback});
                    
% Add button
addButton = uicontrol(addPanel,'Style','pushbutton',...
                        'Units','normalized',...
                        'FontSize',20,...
                        'String','Add',...
                        'Position',[.15,.25,.7,.5],...
                        'Callback',{@add_callback});
                    
    % Callback for the Tool button
    function tool_callback(obj,eventdata)
        
        %%% Written by Sam Fung %%%
        % grabs the input data
        
        statText = get(statusPopup,'Value');
        nameText = get(personEdit,'String');
        
        %if the input is a student, checks to see if the student exist and
        %if it exists sets t.info to the school name for later use.
        if statText==1
            studentArr=cOut.Students;
            b = false;
            for l = 1:length(studentArr)
                if strcmp(nameText,studentArr{l}.Name)
                    b = true;
                    toolWasPressed = 1;
                    cOut.Info{1} = studentArr{l}.School;
                end
            end
            
            %If the student exists, b is true, if not b is false. If the
            %student doesnt exist, an error pops up. It also sets the value
            %of k. if K is true, when a student doesnt exist, the remaining
            %code doesnt happen.
            if b
                k=0;
            else
                errordlg(sprintf('%s does not exist', nameText),'Error')
                k=1;
            end
        %if the input is a mentor, checks to see if the mentor exist and
        %if it exists sets t.info to the school name for later use.    
        elseif statText==2
            mentArr=cOut.Mentors;
            b = false;
            for l = 1:length(mentArr)
                if strcmp(nameText,mentArr{l}.Name)
                    b = true;
                    toolWasPressed = 1;
                    cOut.Info{1} = mentArr{l}.School;
                end
            end
            
            %If the student exists, b is true, if not b is false. If the
            %student doesnt exist, an error pops up. It also sets the value
            %of k. if K is true, when a student doesnt exist, the remaining
            %code doesnt happen.
            if b
                k=0;
            else
                errordlg(sprintf('%s does not exist', nameText),'Error')
                k=1;
            end
            
        end
                      
        %%% End Sam's code %%% 
        
        if k~=1;
            %Sets the panels to invisible 
            set(addPanel,'Visible','off');
            set(toolpurchPanel,'Visible','off');
            set(orText,'Visible','off');
            set(mainscreen,'Position',[pos(1:2),700,400]);
            set(mainscreen,'Name','Tool Checkout');
            
            %makes new panels for the next screens
            leftPanel = uipanel('Parent',mainscreen,'Position',[0,.15,.5,1]);
            rightPanel = uipanel('Parent',mainscreen,'Position',[.5,.15,1,1]);
            bottomlPanel = uipanel('Parent',mainscreen,'Position',[0,0,.5,.15]);
            bottomrPanel = uipanel('Parent',mainscreen,'Position',[.5,0,1,.15]);

            % Back button
            tool_backButton = uicontrol(bottomrPanel,'Style','pushbutton',...
                                        'String','Back',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.05,.2,.4,.6],...
                                        'Callback',{@toolBack_callback});

            % Staff Check
            tool_staffText = uicontrol(bottomlPanel,'Style','text',...
                                        'String','Staff Name:',...
                                        'FontSize',10,...
                                        'Units','normalized',...
                                        'Position',[.025,.175,.2,.5]);
            tool_staffEdit = uicontrol(bottomlPanel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.25,.25,.675,.5]);

            % Person's School
            tool_schoolText = uicontrol(leftPanel,'Style','text',...
                                        'String','School Name',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.125,.7,.75,.1]);
            tool_schoolText2 = uicontrol(leftPanel,'Style','text',...
                                        'String','N/A',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.125,.61,.75,.1]);
                                    
            %Updates the school field in the text box on the new screen                         
            if toolWasPressed
                tool_schoolText2.String = cOut.Info{1};
            end
            
            % Tools already checked out
            tool_checkedoutText = uicontrol(leftPanel,'Style','text',...
                                        'String','Tools Checked Out',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.125,.5,.75,.1]);
            % Tool Checkout Log Table
            tool_checkedoutTable = uitable(leftPanel,'Units','normalized',...
                                        'Position',[.1,.075,.8,.425],...
                                        'ColumnWidth', {245});

            % Tool to be checked out/in
            tool_Text = uicontrol(rightPanel,'Style','text',...
                                        'String','Tool Name',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[0,.7,.5,.1]);
            tool_Edit = uicontrol(rightPanel,'Style','edit',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.1,.63,.3,.1]);

            % Quantity to be checked out
            tool_quantityText = uicontrol(rightPanel,'Style','text',...
                                        'String','Quantity',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[0,.5,.5,.1]);
            tool_quantityEdit = uicontrol(rightPanel,'Style','edit',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.1,.43,.3,.1]);

            % Check Out button
            tool_checkoutButton = uicontrol(rightPanel,'Style','pushbutton',...
                                        'String','Check Out',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.25,.125,.2,.2],...
                                        'Callback',{@toolCheckOut_callback});

            % Check In button
            tool_checkinButton = uicontrol(rightPanel,'Style','pushbutton',...
                                        'String','Return',...
                                        'FontSize',15,...
                                        'Units','normalized',...
                                        'Position',[.05,.125,.2,.2],...
                                        'Callback',{@toolCheckIn_callback});                      
        end

        function toolCheckIn_callback(obj,eventdata)
            %%% Written by Alice Chow %%%
            %gathers info from the input fields
            staff = get(tool_staffEdit, 'String');
            if isempty(staff)
                % no staff name was inputted
                errordlg('Please enter a staff name.', 'Error');
            else
                staffArray = cOut.Staffs;
                a = false; % staff existance
                for i = 1:length(staffArray)
                    % finding the staff member
                    x = strcmp(staff, staffArray{i}.Name);
                    if x
                        % staff member exists
                        a = true;
                        tool = get(tool_Edit, 'String');
                        quantity = str2num(get(tool_quantityEdit, 'String'));
                        %gets the data from the toolCheckout object.
                        toolArr = cOut.Tools;
                        b = false;
                        %loop that compares the input tool name to the list of tool
                        %names saved, if not it errors out
                        for i = 1:length(toolArr)
                            x = strcmp(tool, toolArr{i}.Name);
                            if x
                                %calculate the new quantity of tools available. and
                                %writes that value to the Database and toolChecout obj
                                b = true; 
                                toolArr{i}.Quantity = toolArr{i}.Quantity + quantity;
                                A = sprintf('B%d', i);
                                xlswrite('Database.xlsx', toolArr{i}.Quantity, 'Tool', A);
                                logtext=sprintf('%s has returned %d of %s',nameText,quantity,tool);
                                tool_checkedoutTable.Data{end+1,1}=logtext;
                                %the next three lines keep track of the check out in
                                %the Tool log.
                                [~,txt,~]=xlsread('Database.xlsx','Tool Log','A:A');
                                L=length(txt)+1;
                                xlswrite('Database.xlsx',{logtext,datestr(datetime('now'))},'Tool Log',sprintf('A%d:B%d',L,L));
                                msgbox('Tool has been checked in!');
                            end
                        end
                        if ~b
                            errordlg(sprintf('%s does not exist!', tool), 'Error');
                        end
                    end
                end
                if ~a
                    % not a staff
                    errordlg(sprintf('%s is not a staff member.', staff), 'Error');
                end
            end
        end
        
        function toolCheckOut_callback(obj,eventdata)
            %%% Written by Alice Chow %%%
            %gathers info from the input fields
            staff = get(tool_staffEdit, 'String');
            if isempty(staff)
                % no staff name was inputted
                errordlg('Please enter a staff name.', 'Error');
            else
                staffArray = cOut.Staffs;
                a = false; % staff existance
                for i = 1:length(staffArray)
                    % finding the staff member
                    x = strcmp(staff, staffArray{i}.Name);
                    if x
                        % staff member exists
                        a = true;
                        tool = get(tool_Edit, 'String');
                        quantity = str2num(get(tool_quantityEdit, 'String'));
                        toolArr = cOut.Tools;
                        b = false;
                        %Checks to see if the Tool name exists, if not, the loop errors
                        %out
                        for i = 1:length(toolArr)
                            x = strcmp(tool, toolArr{i}.Name);
                            if x
                                b = true;
                                %the below does the exact same as for the return button
                                %previously, but for checking out. So it subtracts
                                %quantity rather than adding.
                                if (toolArr{i}.Quantity >= quantity &&...
                                    toolArr{i}.Quantity > 0)
                                    toolArr{i}.Quantity = toolArr{i}.Quantity - quantity;
                                    A = sprintf('B%d', i);
                                    xlswrite('Database.xlsx', toolArr{i}.Quantity, 'Tool', A);
                                    logtext=sprintf('%s has checked out %d of %s',nameText,quantity,tool);
                                    tool_checkedoutTable.Data{end+1,1}=logtext;
                                    [~,txt,~]=xlsread('Database.xlsx','Tool Log','A:A');
                                    L=length(txt)+1;
                                    xlswrite('Database.xlsx',{logtext,datestr(datetime('now'))},'Tool Log',sprintf('A%d:B%d',L,L));
                                    msgbox('Tool has been checked out!');
                                else
                                    errordlg('There are not enough of this tool.  Please enter a smaller quantity',...
                                        'Error');
                                end
                            end
                        end
                        if ~b
                            errordlg(sprintf('%s does not exist!', tool), 'Error');
                        end
                    end
                end
                if ~a
                    % not a staff
                    errordlg(sprintf('%s is not a staff member.', staff), 'Error');
                end
            end
        end
        
        %Call back to set the main screen panels visible.
        function toolBack_callback(obj,eventdata)
            set(leftPanel,'Visible','off');
            set(rightPanel,'Visible','off');
            set(bottomlPanel,'Visible','off');
            set(bottomrPanel,'Visible','off');
            set(addPanel,'Visible','on');
            set(toolpurchPanel,'Visible','on');
            set(orText,'Visible','on');
            set(mainscreen,'Position',[pos(1:2),400,400]);
        end

    end

    % Callback for the Purchase button
    function purchase_callback(obj,eventdata)
        %%% Written by Sam Fung %%%
        %gathers input data
        statText = get(statusPopup,'Value');
        nameText = get(personEdit,'String');
        
        %if the status of the person is a student. If so sets b to true and
        %t.info to the school associated with the student.
        if statText==1
            studentArr=cOut.Students;
            b = false;
            for l = 1:length(studentArr)
                if strcmp(nameText,studentArr{l}.Name)
                    b = true;
                    purchaseWasPressed = 1;
                    cOut.Info{2} = studentArr{l}.School;
                end
            end
            
            %If the student exists, b is true, if not b is false. If the
            %student doesnt exist, an error pops up. It also sets the value
            %of kk. if kk is true, when a student doesnt exist, the remaining
            %code doesnt happen.
            if b
                kk=0;
            else
                errordlg(sprintf('%s does not exist', nameText),'Error')
                kk=1;
            end
        %if the status of the input is a mentor    
        elseif statText==2
            mentArr=cOut.Mentors;
            b = false;
            for l = 1:length(mentArr)
                if strcmp(nameText,mentArr{l}.Name)
                    b = true;
                    purchaseWasPressed = 1;
                    cOut.Info{2} = mentArr{l}.School; 
                end
            end
            
            %If the mentor exists, b is true, if not b is false. If the
            %mentor doesnt exist, an error pops up. It also sets the value
            %of kk. if kk is true, when a student doesnt exist, the remaining
            %code doesnt happen.
            if b
                kk=0;
            else
                errordlg(sprintf('%s does not exist', nameText),'Error')
                kk=1;
            end
            
        end
                        
         %%% End of Sam Fung's Code %%%
        
        if kk~=1            
            %Sets the panels to invisible 
            set(addPanel,'Visible','off');
            set(toolpurchPanel,'Visible','off');
            set(orText,'Visible','off');
            set(mainscreen,'Position',[pos(1:2),700,400]);
            set(mainscreen,'Name','Purchasable Screen');
            
            %Sets the panels for the Purchase features as visible.
            leftPanel = uipanel('Parent',mainscreen,'Position',[0,.15,.5,1]);
            rightPanel = uipanel('Parent',mainscreen,'Position',[.5,.15,1,1]);
            bottomlPanel = uipanel('Parent',mainscreen,'Position',[0,0,.5,.15]);
            bottomrPanel = uipanel('Parent',mainscreen,'Position',[.5,0,1,.15]);

            % Back button
            purchase_backButton = uicontrol(bottomrPanel,'Style','pushbutton',...
                                            'String','Back',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[.05,.2,.4,.6],...
                                            'Callback',{@purchaseBack_callback});

            % Staff Name
            purchase_staffText = uicontrol(bottomlPanel,'Style','Text',...
                                            'String','Staff Name:',...
                                            'FontSize',10,...
                                            'Units','normalized',...
                                            'Position',[.025,.175,.2,.5]);
            purchase_staffEdit = uicontrol(bottomlPanel,'Style','edit',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[.25,.25,.675,.5]);

            % Person's School
            purchase_schoolText = uicontrol(leftPanel,'Style','text',...
                                            'String','School Name',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[.125,.725,.75,.1]);
            purchase_schoolText2 = uicontrol(leftPanel,'Style','text',...
                                            'String','N/A',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.125,.66,.75,.1]);
                                        
            %Updates the school field in the text box on the new screen
            if purchaseWasPressed
                purchase_schoolText2.String = cOut.Info{1};
            end

            % School's remaining PandaPoints
            purchase_pointsText = uicontrol(leftPanel,'Style','text',...
                                            'String','Remaining PandaPoints',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[.125,.55,.75,.1]);
            purchase_pointsText2 = uicontrol(leftPanel,'Style','Text',...
                                            'String','N/A',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.125,.485,.75,.1]);
                                        
            %Updates the PandaPoints field in the text box on the new screen
            if purchaseWasPressed
                purchase_schoolText2.String = cOut.Info{2};
                for i = 1:length(cOut.Schools)
                    if strcmp(cOut.Schools{i}.Name,purchase_schoolText2.String)
                        purchase_pointsText2.String=cOut.Schools{i}.PandaPoints;
                    end
                end
            end
            

            % Past purchases
            purchase_purchasesText = uicontrol(leftPanel,'Style','text',...
                                            'String','Purchases',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[.125,.375,.75,.1]);
            % Purchases log table
            purchase_purchasesTable = uitable(leftPanel,'Units','normalized',...
                                            'Position',[.1,.075,.8,.325],...
                                            'ColumnWidth', {245});

            % Item to be purchased/returned
            purchase_itemText = uicontrol(rightPanel,'Style','text',...
                                            'String','Purchasable',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[0,.7,.5,.1]);
            purchase_itemEdit = uicontrol(rightPanel,'Style','edit',...
                                            'FontSize',15,...
                                            'Unit','normalized',...
                                            'Position',[.1,.65,.3,.1]);

            % Quantity to be purchased/returned
            purchase_quantityText = uicontrol(rightPanel,'Style','text',...
                                            'String','Quantity',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[0,.525,.335,.1]);
            purchase_quantityEdit = uicontrol(rightPanel,'Style','edit',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.1,.475,.135,.1]);

            % Update button
            purchase_updateButton = uicontrol(rightPanel,'Style','pushbutton',...
                                            'String','Update',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.26,.475,.135,.125],...
                                            'Callback',@purchaseUpdate_callback);

            % Cost of purchase
            purchase_costText = uicontrol(rightPanel,'Style','text',...
                                            'String','Cost',...
                                            'FontSize',12,...
                                            'Units','normalized',...
                                            'Position',[0,.35,.5,.1]);
            purchase_costText2 = uicontrol(rightPanel,'Style','text',...
                                            'String','N/A',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.1,.285,.3,.1]);

            % Return button
            purchase_returnButton = uicontrol(rightPanel,'Style','pushbutton',...
                                            'String','Return',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.05,.075,.2,.15],...
                                            'Callback',{@purchaseReturn_callback});

            % Buy button
            purchase_buyButton = uicontrol(rightPanel,'Style','pushbutton',...
                                            'String','Buy',...
                                            'FontSize',15,...
                                            'Units','normalized',...
                                            'Position',[.25,.075,.2,.15],...
                                            'Callback',{@purchaseBuy_callback});
        end

       
        
        function purchaseUpdate_callback(obj,eventdata)
           %%% Written by Mandy Chen %%%
           %Update button checks to see if the item exists, and if so it
           %will display the PandaPoint cost in the text field below.
           %gets the input information.
           item = get(purchase_itemEdit,'String');
           quantity = get(purchase_quantityEdit,'String');
           %checks to see if the fields arent empty
           if ~isempty(item) && ~isempty(quantity)
               [num,txt,raw] = xlsread('Database.xlsx','Purchase');
               for i = 1:length(num)
                   %if the item exists, multiples the item cost by the
                   %number requested.
                   if strcmp(item,txt(i,1))
                       cost = cell2mat(raw(i,2))*str2double(quantity);
                       set(purchase_costText2,'String',cost);
                       return;
                   end
               end
               errordlg('Purchasable or Quantity does not exist.','Error');
           else
               errordlg('You need to fill out both Purchasable and Quantity Fields','Error');
           end
        end
                                    
        function purchaseReturn_callback(obj,eventdata)
            %%% Written by Mandy Chen %%%
            %Callback for returning a purchasable
            %getting data and setting variables.
            purchasable = get(purchase_itemEdit,'String');
            quantity = str2double(get(purchase_quantityEdit,'String'));
            cost = str2double(get(purchase_costText2,'String'));
            purchArr = cOut.Purchasables;
            points = str2double(get(purchase_pointsText2,'String'));
            schoolArr = cOut.Schools;
            staff = get(purchase_staffEdit,'String');
            staffArr = cOut.Staffs;
            %Checks to see if the Staff exists, then if the input fields
            %arent empty, and then if the purchasable requested is in the
            %system.
            for v = 1:length(staffArr)
                if strcmp(staff,staffArr{v}.Name)
                    if ~isempty(purchasable) && ~isempty(quantity) && ~isempty(cost)
                        for p = 1:length(purchArr)
                            if strcmp(purchasable,purchArr{p}.Name)
                                %grabs the quantity and sets the new one,
                                %then writes to the Database.
                                quant = purchArr{p}.Quantity;
                                purchArr{p}.Quantity = quant + quantity;
                                xlswrite('Database.xlsx',purchArr{p}.Quantity,'Purchase',sprintf('C%d',p));
                                updatePoints = points + cost;
                                %the following code updates the Points of
                                %the School, and creates an entry in the
                                %Purchase Log, as well as displays a
                                %success message.
                                for n=1:length(cOut.Schools)
                                    if strcmp(cOut.Schools{n}.Name,get(purchase_schoolText2,'String'))
                                        schoolArr{n}.PandaPoints = updatePoints;
                                        xlswrite('Database.xlsx',updatePoints,'School',sprintf('B%d',n));
                                        set(purchase_pointsText2,'String',updatePoints);
                                        logtext=sprintf('%s has returned %d of %s',nameText,quantity,purchasable);
                                        purchase_purchasesTable.Data{end+1,1}=logtext;
                                        [~,txt,~]=xlsread('Database.xlsx','Purchase Log','A:A');
                                        L=length(txt)+1;
                                        xlswrite('Database.xlsx',{logtext,datestr(datetime('now'))},'Purchase Log',sprintf('A%d:B%d',L,L));
                                        msgbox('Return has been completed!')
                                        return;
                                    end
                                end
                            end
                        end
                    else
                        errordlg('You need to fill out and update all the fields','Error');
                    end
                end
            end
            errordlg('Input existing staff.')
        end
        
        function purchaseBuy_callback(obj,eventdata)
            %%% Written by Alice Chow %%%
            staff = get(purchase_staffEdit, 'String');
            if isempty(staff)
                % no staff name was inputted
                errordlg('Please enter a staff name.', 'Error');
            else
                staffArray = cOut.Staffs;
                a = false; % staff existance
                for i = 1:length(staffArray)
                    % finding the staff member
                    x = strcmp(staff, staffArray{i}.Name);
                    if x
                        % staff member exists
                        a = true;
                        item = get(purchase_itemEdit, 'String');
                        quantity = str2num(get(purchase_quantityEdit, 'String'));
                        cost = str2num(get(purchase_costText2, 'String'));
                        school = get(purchase_schoolText2, 'String');
                        pp = str2num(get(purchase_pointsText2, 'String'));
                        purchaseArray = cOut.Purchasables;
                        schoolArray = cOut.Schools;
                        b = false; % item existance
                        for j = 1:length(purchaseArray)
                            % loop to correct purchase item
                            y = strcmp(item, purchaseArray{j}.Name);
                            if y
                                % item exists
                                b = true;
                                if (purchaseArray{j}.Quantity >= quantity && ...
                                        purchaseArray{j}.Quantity > 0)
                                    % there is enough of the item
                                    for k = 1:length(schoolArray)
                                        % loop to correct school
                                        z = strcmp(school, schoolArray{k}.Name);
                                        if z
                                            % current k is the correct
                                            % school purchases the item,
                                            % records in the Purchase Log
                                            % and then displays a Sucess
                                            % message.
                                            if pp >= cost
                                                schoolArray{k}.PandaPoints = schoolArray{k}.PandaPoints - cost;
                                                purchase_pointsText2.String = schoolArray{k}.PandaPoints;
                                                A = sprintf('B%d', k);
                                                xlswrite('Database.xlsx', schoolArray{k}.PandaPoints, 'School', A);
                                                purchaseArray{j}.Quantity = purchaseArray{j}.Quantity - quantity;
                                                A = sprintf('C%d', j);
                                                xlswrite('Database.xlsx', purchaseArray{j}.Quantity, 'Purchase', A);
                                                logtext=sprintf('%s has purchased %d of %s',nameText,quantity,item);
                                                purchase_purchasesTable.Data{end+1,1}=logtext;
                                                [~,txt,~]=xlsread('Database.xlsx','Purchase Log','A:A');
                                                L=length(txt)+1;
                                                xlswrite('Database.xlsx',{logtext,datestr(datetime('now'))},'Purchase Log',sprintf('A%d:B%d',L,L));
                                                msgbox('Item has been purchased!');
                                            else
                                                errordlg(sprintf('%s does not have enough Panda Points for this purchase.', school), 'Error');
                                            end
                                        end
                                    end
                                else
                                    errordlg('There is not enough of this object.  Please enter a smaller quantity.', 'Error');
                                end
                            end
                        end
                        if ~b
                            % item does not exist
                            errordlg(sprintf('%s does not exist!', item), 'Error');
                        end
                    end
                    
                end
                if ~a
                    % not a staff
                    errordlg(sprintf('%s is not a staff member.', staff), 'Error');
                end
            end
        end
        
        %Callback for going back to the main page, sets the panels to
        %visible
        function purchaseBack_callback(obj,eventdata)
            set(leftPanel,'Visible','off');
            set(rightPanel,'Visible','off');
            set(bottomlPanel,'Visible','off');
            set(bottomrPanel,'Visible','off');
            set(addPanel,'Visible','on');
            set(toolpurchPanel,'Visible','on');
            set(orText,'Visible','on');
            set(mainscreen,'Position',[pos(1:2),400,400]);
        end
        
    end

    % Callback for the Add button
    function add_callback(obj,eventdata)
        %sets the size and position of the panel and figure for the Add
        %buttons.
        set(addPanel,'Visible','off');
        set(toolpurchPanel,'Visible','off');
        set(orText,'Visible','off');
        set(mainscreen,'Position',[pos(1:2),600,150]);
        set(mainscreen,'Name','Add Screen');
        
        addPanel2 = uipanel('Parent',mainscreen,'Position',[0,0,1,1]);
        
        % Add Person button
        addPersonButton = uicontrol(addPanel2,'Style','pushbutton',...
                                    'String','Person',...
                                    'Units','normalized',...
                                    'FontSize',15,...
                                    'Position',[.075,.5,.25,.3],...
                                    'Callback',{@addPerson_callback});
        % Add Tool button
        addToolButton = uicontrol(addPanel2,'Style','pushbutton',...
                                    'String','Tool',...
                                    'Units','normalized',...
                                    'FontSize',15,...
                                    'Position',[.375,.5,.25,.3],...
                                    'Callback',{@addTool_callback});
        % Add Purchasable button
        addPurchaseButton = uicontrol(addPanel2,'Style','pushbutton',...
                                    'String','Purchasable',...
                                    'Units','normalized',...
                                    'FontSize',15,...
                                    'Position',[.675,.5,.25,.3],...
                                    'Callback',{@addPurchase_callback});
                                
        % Back button
        addBackButton = uicontrol(addPanel2,'Style','pushbutton',...
                                    'String','Back',...
                                    'Units','normalized',...
                                    'FontSize',12,...
                                    'Position',[.425,.15,.15,.25],...
                                    'Callback',{@addBack_callback});

        % Callback for the Add Person button
        function addPerson_callback(obj,eventdata)
            set(addPanel2,'Visible','off');
            set(mainscreen,'Position',[pos(1:2),300,300]);
            set(mainscreen,'Name','Add a Person');
            
            addPerson_panel = uipanel('Parent',mainscreen,'Position',[0,0,1,1]);

            % The person's status/title: Staff/Student/Mentor/Teacher
            person_statusText = uicontrol(addPerson_panel,'Style','text',...
                                        'String','Status',...
                                        'Units','normalized',...
                                        'FontSize',12,...
                                        'Position',[.125,.84,.75,.1]);
            person_statusPopup = uicontrol(addPerson_panel,'Style','popup',...
                                        'FontSize',12,...
                                        'String',{'Student','Mentor','Staff'},...
                                        'Units','normalized',...
                                        'Position',[.125,.77,.75,.1]);

            % The person's name
            person_nameText = uicontrol(addPerson_panel,'Style','text',...
                                        'String','Name',...
                                        'Units','normalized',...
                                        'FontSize',12,...
                                        'Position',[.125,.65,.75,.1]);
            person_nameEdit = uicontrol(addPerson_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.58,.75,.1]);

            % The person's school
            person_schoolText = uicontrol(addPerson_panel,'Style','text',...
                                        'String','School',...
                                        'Units','normalized',...
                                        'FontSize',12,...
                                        'Position',[.125,.46,.75,.1]);
            person_schoolEdit = uicontrol(addPerson_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.39,.75,.1]);

            % Add button
            person_addButton = uicontrol(addPerson_panel,'Style','pushbutton',...
                                        'FontSize',12,...
                                        'String','Add',...
                                        'Units','normalized',...
                                        'Position',[.55,.1,.3,.2],...
                                        'Callback',{@personAdd_callback});

            % Back button
            person_backButton = uicontrol(addPerson_panel,'Style','pushbutton',...
                                        'FontSize',12,...
                                        'String','Back',...
                                        'Units','normalized',...
                                        'Position',[.125,.1,.3,.2],...
                                        'Callback',{@personBack_callback});
                                    
            % Back button callback                        
            function personBack_callback(obj,eventdata)
                add_callback;
                set(addPerson_panel,'Visible','off');
            end
            
            % Add button callback
            %%% Anthony's Work %%%
            function personAdd_callback(obj,eventdata)
                %gathers the information from the input fields
                StatusValue=get(person_statusPopup,'Value');
                NameString=get(person_nameEdit,'String');
                SchoolString=get(person_schoolEdit,'String');
                
                %if the person to add is a Staff
                if StatusValue==3
                    %checks if the person already exists
                    for j=1:length(cOut.Staffs)
                        if strcmp(cOut.Staffs{j}.Name,NameString)
                           errordlg('This Staff member already exists!')
                           return
                        end
                    end
                    %adds the Staff to Database and the toolCheckout obj.
                    L=length(cOut.Staffs);
                    A=sprintf('A%d',L+1);
                    xlswrite('Database.xlsx',{NameString},'Staff',A);
                    cOut.Staffs{end+1}=Staff(NameString);
                    cOut.Staffs{end}.setStatus('Staff');
                
                %if the person to be added is a Mentor    
                elseif StatusValue==2
                    %checks to see if the Mentor exists
                    for j=1:length(cOut.Mentors)
                        if strcmp(cOut.Mentors{j}.Name,NameString)
                           errordlg('This Mentor already exists!')
                           return
                        end
                    end
                    %adds the Mentor to the Database and toolCheckout obj
                    L=length(cOut.Mentors);
                    A=sprintf('A%d:B%d',L+1,L+1);
                    xlswrite('Database.xlsx',{NameString,SchoolString},'Mentor',A);
                    cOut.Mentors{end+1}=Mentor(NameString);
                    cOut.Mentors{end}.setSchool(SchoolString);
                    cOut.Mentors{end}.setStatus('Mentor');
                
                %if the person to be added is a Student    
                elseif StatusValue==1
                    %if the Student doesnt exist
                    for j=1:length(cOut.Students)
                        if strcmp(cOut.Students{j}.Name,NameString)
                           errordlg('This Student already exists!')
                           return
                        end
                    end
                    %adds the Student to the Database and toolCheckout obj
                    L=length(cOut.Students);
                    A=sprintf('A%d:B%d',L+1,L+1);
                    xlswrite('Database.xlsx',{NameString,SchoolString},'Student',A);
                    cOut.Students{end+1}=Student(NameString);
                    cOut.Students{end}.setSchool(SchoolString);
                    cOut.Students{end}.setStatus('Student');
                end
                msgbox(sprintf('Success! %s has been added!',NameString));
            end
                %%% End of Anthony's Work %%%
        end
        
        % Callback for the Add Tool button
        function addTool_callback(obj,eventdata)
            set(addPanel2,'Visible','off');
            set(mainscreen,'Position',[pos(1:2),300,300]);
            set(mainscreen,'Name','Add a Tool');
            
            addTool_panel = uipanel('Parent',mainscreen,'Position',[0,0,1,1]);
            
            % The name of the tool
            tool_nameText = uicontrol(addTool_panel,'Style','text',...
                                        'FontSize',12,...
                                        'String','Tool Name',...
                                        'Units','normalized',...
                                        'Position',[.125,.825,.75,.1]);
            tool_nameEdit = uicontrol(addTool_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.75,.75,.1]);
            
            % The code of the tool                        
            tool_quantText = uicontrol(addTool_panel,'Style','text',...
                                        'String','Tool Quantity',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.56,.75,.1]);
            tool_quantEdit = uicontrol(addTool_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.49,.75,.1]);
                                    
            % Back button
            tool_backButton = uicontrol(addTool_panel,'Style','pushbutton',...
                                        'String','Back',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.15,.3,.2],...
                                        'Callback',{@toolBack_callback});
                                
            % Add button
            tool_addButton = uicontrol(addTool_panel,'Style','pushbutton',...
                                        'String','Add',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.55,.15,.3,.2],...
                                        'Callback',{@toolAdd_callback});
            
            % Back button callback
            function toolBack_callback(obj,eventdata)
                add_callback;
                set(addTool_panel,'Visible','off');
            end
            
            % Add button callback
            %%%% Anthony's Work %%%
            function toolAdd_callback(obj,eventdata)
                %gets information from the input fields.
                ToolName=get(tool_nameEdit,'String');
                ToolQuant=str2double(get(tool_quantEdit,'String'));
                
                %checks to see if the tool exists or not
                for j=1:length(cOut.Tools)
                    if strcmp(cOut.Tools{j}.Name,ToolName)
                        errordlg('This Tool already exists!')
                        return
                    end
                end
                %adds the tool to the Database and the toolCheckout obj
                L=length(cOut.Tools);
                A=sprintf('A%d:B%d',L+1,L+1);
                xlswrite('Database.xlsx',{ToolName,ToolQuant},'Tool',A);
                cOut.Tools{end+1}=Tool(ToolName);
                cOut.Tools{end}.setQuantity(ToolQuant);
                msgbox(sprintf('Success! %d %s has been added!',ToolQuant,ToolName));
            end
            %%% End of Anthony's Work %%%
        end
        
        % Callback for the Add Purchasable button
        function addPurchase_callback(obj,eventdata)
            set(addPanel2,'Visible','off');
            set(mainscreen,'Position',[pos(1:2),300,300]);
            set(mainscreen,'Name','Add a Purchasable');
            
            addPurchase_panel = uipanel('Parent',mainscreen,'Position',[0,0,1,1]);
            
            % The name of the Purchasable
            purchase_nameText = uicontrol(addPurchase_panel,'Style','text',...
                                        'String','Purchasable Name',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.85,.75,.1]);
            purchase_nameEdit = uicontrol(addPurchase_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.78,.75,.1]);
            
            % The code of the Purchasable
            purchase_quantText = uicontrol(addPurchase_panel,'Style','text',...
                                        'String','Purchasable Quanitity',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.66,.75,.1]);
            purchase_quantEdit = uicontrol(addPurchase_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.59,.75,.1]);
            
            % The number of PandaPoints of the purchasable
            purchase_pointsText = uicontrol(addPurchase_panel,'Style','text',...
                                        'String','PandaPoint Cost',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.47,.75,.1]);
            purchase_pointsEdit = uicontrol(addPurchase_panel,'Style','edit',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.4,.75,.1]);
            
            % Back button 
            purchase_backbutton = uicontrol(addPurchase_panel,'Style','pushbutton',...
                                        'String','Back',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.125,.1,.3,.2],...
                                        'Callback',{@purchaseBack_callback});
            
            % Add button 
            purchase_addbutton = uicontrol(addPurchase_panel,'Style','pushbutton',...
                                        'String','Add',...
                                        'FontSize',12,...
                                        'Units','normalized',...
                                        'Position',[.55,.1,.3,.2],...
                                        'Callback',{@purchaseAdd_callback});
            
            % Back button callback
            function purchaseBack_callback(obj,eventdata)
                add_callback;
                set(addPurchase_panel,'Visible','off');
            end
            
            % Add button callback
            
            %%% Anthony's Work %%%
            function purchaseAdd_callback(obj,eventdata)
               %gathers the input information
               PurchName=get(purchase_nameEdit,'String');
               PurchQuant=str2double(get(purchase_quantEdit,'String'));
               PurchCost=str2double(get(purchase_pointsEdit,'String'));
               %checks if the Purchasable exists
               for j=1:length(cOut.Purchasables)
                    if strcmp(cOut.Purchasables{j}.Name,PurchName)
                        errordlg('This Purchasable already exists!')
                        return
                    end
               end
               %adds the Purchasable to the Database and the toolCheckout object 
               L=length(cOut.Purchasables);
               A=sprintf('A%d:C%d',L+1,L+1);
               xlswrite('Database.xlsx',{PurchName,PurchCost,PurchQuant},'Purchase',A);
               cOut.Purchasables{end+1}=Purchase(PurchName);
               cOut.Purchasables{end}.setPrice(PurchCost);
               cOut.Purchasables{end}.setQuantity(PurchQuant);
               msgbox(sprintf('Success! %d, %s that cost $%3.3g has been added!',PurchQuant,PurchName,PurchCost));
            end
            %%% End of Anthony's Work %%%
        end
        
        % Callback for the Add Back button
        function addBack_callback(obj,eventdata)
            set(addPanel2,'Visible','off');
            set(addPanel,'Visible','on');
            set(toolpurchPanel,'Visible','on');
            set(orText,'Visible','on');
            set(mainscreen,'Position',[pos(1:2),400,400]);
        end
    end
end
