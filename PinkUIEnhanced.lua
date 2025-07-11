        colorWheel.Visible = colorWheelState.isOpen;
    end);
    
    -- // gradient toggle button
    local gradToggle = Instance.new("TextButton");
    gradToggle.Size = UDim2.new(0, 25, 0, 25);
    gradToggle.Position = UDim2.new(1, -170, 0, 70);
    gradToggle.BackgroundColor3 = clrs.accent;
    gradToggle.BorderSizePixel = 0;
    gradToggle.Text = "G";
    gradToggle.TextColor3 = gradientEnabled and clrs.pink or clrs.grey;
    gradToggle.TextSize = 12;
    gradToggle.Font = Enum.Font.GothamBold;
    gradToggle.Parent = titlebar;
    
    uiElements.gradientButton = gradToggle;
    
    local gradCorner = Instance.new("UICorner");
    gradCorner.CornerRadius = UDim.new(0, 6);
    gradCorner.Parent = gradToggle;
    
    gradToggle.MouseButton1Click:Connect(function()
        gradientEnabled = not gradientEnabled;
        if gradientEnabled then
            if not titlegrad then
                titlegrad = Instance.new("UIGradient");
                titlegrad.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, clrs.pink),
                    ColorSequenceKeypoint.new(0.5, clrs.lightpink),
                    ColorSequenceKeypoint.new(1, clrs.pink)
                };
                titlegrad.Offset = Vector2.new(-1, 0);
                uiElements.titleGradient = titlegrad;
            end;
            titlegrad.Parent = titlelbl;
            gradToggle.TextColor3 = clrs.pink;
            
            spawn(function()
                while titlelbl.Parent and gradientEnabled and titlegrad.Parent do
                    createtween(titlegrad, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Offset = Vector2.new(1, 0)
                    }):Play();
                    wait(2.5);
                    if titlegrad.Parent then
                        createtween(titlegrad, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Offset = Vector2.new(-1, 0)
                        }):Play();
                        wait(2.5);
                    end;
                end;
            end);
        else
            if titlegrad then
                titlegrad.Parent = nil;
            end;
            titlelbl.TextColor3 = clrs.white;
            gradToggle.TextColor3 = clrs.grey;
        end;
    end);
    
    -- // subtitle
    local subtitlelbl = Instance.new("TextLabel");
    subtitlelbl.Name = "Subtitle";
    subtitlelbl.Size = UDim2.new(1, -200, 0, 18);
    subtitlelbl.Position = UDim2.new(0, 25, 0, 88);
    subtitlelbl.BackgroundTransparency = 1;
    subtitlelbl.Text = subtitle;
    subtitlelbl.TextColor3 = clrs.grey;
    subtitlelbl.TextSize = 13;
    subtitlelbl.Font = Enum.Font.Gotham;
    subtitlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    subtitlelbl.Parent = titlebar;
    
    -- // minimize button
    local minbtn = Instance.new("TextButton");
    minbtn.Name = "Minimize";
    minbtn.Size = UDim2.new(0, 35, 0, 35);
    minbtn.Position = UDim2.new(1, -85, 0, 67);
    minbtn.BackgroundColor3 = clrs.accent;
    minbtn.BackgroundTransparency = 0.6;
    minbtn.BorderSizePixel = 0;
    minbtn.Text = "−";
    minbtn.TextColor3 = clrs.grey;
    minbtn.TextSize = 18;
    minbtn.Font = Enum.Font.GothamBold;
    minbtn.Parent = titlebar;
    
    local mincorner = Instance.new("UICorner");
    mincorner.CornerRadius = UDim.new(0, 8);
    mincorner.Parent = minbtn;
    
    -- // close button
    local closebtn = Instance.new("TextButton");
    closebtn.Name = "Close";
    closebtn.Size = UDim2.new(0, 35, 0, 35);
    closebtn.Position = UDim2.new(1, -45, 0, 67);
    closebtn.BackgroundColor3 = clrs.red;
    closebtn.BackgroundTransparency = 0.6;
    closebtn.BorderSizePixel = 0;
    closebtn.Text = "✕";
    closebtn.TextColor3 = clrs.white;
    closebtn.TextSize = 14;
    closebtn.Font = Enum.Font.GothamBold;
    closebtn.Parent = titlebar;
    
    local closecorner = Instance.new("UICorner");
    closecorner.CornerRadius = UDim.new(0, 8);
    closecorner.Parent = closebtn;
    
    -- // top separator line
    local topsep = Instance.new("Frame");
    topsep.Name = "TopSeparator";
    topsep.Size = UDim2.new(1, -50, 0, 1);
    topsep.Position = UDim2.new(0, 25, 0, 118);
    topsep.BackgroundColor3 = clrs.separator;
    topsep.BorderSizePixel = 0;
    topsep.Parent = main;
    
    local topsepcorner = Instance.new("UICorner");
    topsepcorner.CornerRadius = UDim.new(0, 1);
    topsepcorner.Parent = topsep;
    
    -- // sidebar with scrolling
    local sidebar = Instance.new("Frame");
    sidebar.Name = "Sidebar";
    sidebar.Size = UDim2.new(0, 220, 1, -135);
    sidebar.Position = UDim2.new(0, 15, 0, 130);
    sidebar.BackgroundTransparency = 1;
    sidebar.BorderSizePixel = 0;
    sidebar.Parent = main;
    
    -- // tab container with scrolling
    local tabcont = Instance.new("ScrollingFrame");
    tabcont.Name = "TabContainer";
    tabcont.Size = UDim2.new(1, 0, 1, 0);
    tabcont.Position = UDim2.new(0, 0, 0, 0);
    tabcont.BackgroundTransparency = 1;
    tabcont.BorderSizePixel = 0;
    tabcont.ScrollBarThickness = 3;
    tabcont.ScrollBarImageColor3 = clrs.pink;
    tabcont.ScrollBarImageTransparency = 0.7;
    tabcont.CanvasSize = UDim2.new(0, 0, 0, 0);
    tabcont.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    tabcont.ScrollingDirection = Enum.ScrollingDirection.Y;
    tabcont.Parent = sidebar;
    
    table.insert(uiElements.scrollbars, tabcont);
    
    local tablayout = Instance.new("UIListLayout");
    tablayout.SortOrder = Enum.SortOrder.LayoutOrder;
    tablayout.Padding = UDim.new(0, 8);
    tablayout.Parent = tabcont;
    
    local tabpad = Instance.new("UIPadding");
    tabpad.PaddingLeft = UDim.new(0, 8);
    tabpad.PaddingRight = UDim.new(0, 8);
    tabpad.PaddingTop = UDim.new(0, 8);
    tabpad.PaddingBottom = UDim.new(0, 8);
    tabpad.Parent = tabcont;
    
    -- // content area
    local content = Instance.new("Frame");
    content.Name = "Content";
    content.Size = UDim2.new(1, -265, 1, -160);
    content.Position = UDim2.new(0, 255, 0, 135);
    content.BackgroundTransparency = 1;
    content.BorderSizePixel = 0;
    content.Parent = main;
    
    -- // vertical separator
    local separator = Instance.new("Frame");
    separator.Name = "VerticalSeparator";
    separator.Size = UDim2.new(0, 1, 1, -135);
    separator.Position = UDim2.new(0, 245, 0, 130);
    separator.BackgroundColor3 = clrs.separator;
    separator.BorderSizePixel = 0;
    separator.BackgroundTransparency = 0.5;
    separator.Parent = main;
    
    local sepcorner = Instance.new("UICorner");
    sepcorner.CornerRadius = UDim.new(0, 1);
    sepcorner.Parent = separator;
    
    -- // drag functionality
    local dragging = false;
    local dragstart = nil;
    local startpos = nil;
    
    titlebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true;
            dragstart = input.Position;
            startpos = main.Position;
        end;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragstart;
            local newpos = UDim2.new(startpos.X.Scale, startpos.X.Offset + delta.X, startpos.Y.Scale, startpos.Y.Offset + delta.Y);
            createtween(main, twinfo.drag, {Position = newpos}):Play();
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false;
        end;
    end);
    
    -- // button hover effects
    minbtn.MouseEnter:Connect(function()
        createtween(minbtn, twinfo.fast, {BackgroundTransparency = 0.2, TextColor3 = clrs.white}):Play();
    end);
    
    minbtn.MouseLeave:Connect(function()
        createtween(minbtn, twinfo.fast, {BackgroundTransparency = 0.6, TextColor3 = clrs.grey}):Play();
    end);
    
    closebtn.MouseEnter:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundTransparency = 0.2}):Play();
    end);
    
    closebtn.MouseLeave:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundTransparency = 0.6}):Play();
    end);
    
    colorBtn.MouseEnter:Connect(function()
        createtween(colorBtn, twinfo.fast, {BackgroundColor3 = clrs.pink, TextColor3 = clrs.white}):Play();
    end);
    
    colorBtn.MouseLeave:Connect(function()
        createtween(colorBtn, twinfo.fast, {BackgroundColor3 = clrs.accent, TextColor3 = clrs.pink}):Play();
    end);
    
    closebtn.MouseButton1Click:Connect(function()
        if greetingConnection then
            greetingConnection:Disconnect();
        end;
        createtween(main, twinfo.bounce, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play();
        wait(0.6);
        gui:Destroy();
    end);
    
    local window = {};
    window.tabs = {};
    window.activetab = nil;
    
    function window:CreateTab(cfg)
        local cfg = cfg or {};
        local name = cfg.Name or "Tab";
        local icon = cfg.Icon or "";
        
        local tabbtn = Instance.new("TextButton");
        tabbtn.Name = name;
        tabbtn.Size = UDim2.new(1, 0, 0, 45);
        tabbtn.BackgroundTransparency = 1;
        tabbtn.BorderSizePixel = 0;
        tabbtn.Text = "";
        tabbtn.Parent = tabcont;
        
        local iconlbl = nil;
        if icon ~= "" then
            iconlbl = Instance.new("TextLabel");
            iconlbl.Size = UDim2.new(0, 24, 0, 24);
            iconlbl.Position = UDim2.new(0, 12, 0.5, -12);
            iconlbl.BackgroundTransparency = 1;
            iconlbl.Text = icon;
            iconlbl.TextColor3 = clrs.darkgrey;
            iconlbl.TextSize = 16;
            iconlbl.Font = Enum.Font.Gotham;
            iconlbl.Parent = tabbtn;
        end;
        
        local tablbl = Instance.new("TextLabel");
        tablbl.Size = UDim2.new(1, iconlbl and -50 or -25, 1, 0);
        tablbl.Position = UDim2.new(0, iconlbl and 42 or 12, 0, 0);
        tablbl.BackgroundTransparency = 1;
        tablbl.Text = name;
        tablbl.TextColor3 = clrs.darkgrey;
        tablbl.TextSize = 15;
        tablbl.Font = Enum.Font.GothamMedium;
        tablbl.TextXAlignment = Enum.TextXAlignment.Left;
        tablbl.Parent = tabbtn;
        
        local textbounds = game:GetService("TextService"):GetTextSize(name, 15, Enum.Font.GothamMedium, Vector2.new(200, 50));
        
        local underline = Instance.new("Frame");
        underline.Name = "Underline";
        underline.Size = UDim2.new(0, 0, 0, 3);
        underline.Position = UDim2.new(0, iconlbl and 42 or 12, 1, -5);
        underline.BackgroundColor3 = clrs.pink;
        underline.BorderSizePixel = 0;
        underline.Parent = tabbtn;
        
        table.insert(uiElements.underlines, underline);
        
        local undercorner = Instance.new("UICorner");
        undercorner.CornerRadius = UDim.new(0, 2);
        undercorner.Parent = underline;
        
        local hoverline = Instance.new("Frame");
        hoverline.Name = "HoverLine";
        hoverline.Size = UDim2.new(0, 0, 0, 2);
        hoverline.Position = UDim2.new(0, iconlbl and 42 or 12, 1, -3);
        hoverline.BackgroundColor3 = clrs.grey;
        hoverline.BorderSizePixel = 0;
        hoverline.Parent = tabbtn;
        
        table.insert(uiElements.hoverlines, hoverline);
        
        local hovercorner = Instance.new("UICorner");
        hovercorner.CornerRadius = UDim.new(0, 1);
        hovercorner.Parent = hoverline;
        
        local tabcontent = Instance.new("ScrollingFrame");
        tabcontent.Name = name .. "Content";
        tabcontent.Size = UDim2.new(1, 0, 1, 0);
        tabcontent.Position = UDim2.new(0, 0, 0, 0);
        tabcontent.BackgroundTransparency = 1;
        tabcontent.BorderSizePixel = 0;
        tabcontent.ScrollBarThickness = 4;
        tabcontent.ScrollBarImageColor3 = clrs.pink;
        tabcontent.ScrollBarImageTransparency = 0.6;
        tabcontent.CanvasSize = UDim2.new(0, 0, 0, 0);
        tabcontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        tabcontent.Visible = false;
        tabcontent.Parent = content;
        
        table.insert(uiElements.scrollbars, tabcontent);
        
        local leftcolumn = Instance.new("ScrollingFrame");
        leftcolumn.Name = "LeftColumn";
        leftcolumn.Size = UDim2.new(0.48, 0, 1, 0);
        leftcolumn.Position = UDim2.new(0, 15, 0, 15);
        leftcolumn.BackgroundTransparency = 1;
        leftcolumn.BorderSizePixel = 0;
        leftcolumn.ScrollBarThickness = 3;
        leftcolumn.ScrollBarImageColor3 = clrs.pink;
        leftcolumn.ScrollBarImageTransparency = 0.8;
        leftcolumn.CanvasSize = UDim2.new(0, 0, 0, 0);
        leftcolumn.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        leftcolumn.Parent = tabcontent;
        
        table.insert(uiElements.scrollbars, leftcolumn);
        
        local leftlayout = Instance.new("UIListLayout");
        leftlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        leftlayout.Padding = UDim.new(0, 12);
        leftlayout.Parent = leftcolumn;
        
        local leftpad = Instance.new("UIPadding");
        leftpad.PaddingLeft = UDim.new(0, 8);
        leftpad.PaddingRight = UDim.new(0, 8);
        leftpad.PaddingTop = UDim.new(0, 8);
        leftpad.PaddingBottom = UDim.new(0, 8);
        leftpad.Parent = leftcolumn;
        
        local rightcolumn = Instance.new("ScrollingFrame");
        rightcolumn.Name = "RightColumn";
        rightcolumn.Size = UDim2.new(0.48, 0, 1, 0);
        rightcolumn.Position = UDim2.new(0.52, 0, 0, 15);
        rightcolumn.BackgroundTransparency = 1;
        rightcolumn.BorderSizePixel = 0;
        rightcolumn.ScrollBarThickness = 3;
        rightcolumn.ScrollBarImageColor3 = clrs.pink;
        rightcolumn.ScrollBarImageTransparency = 0.8;
        rightcolumn.CanvasSize = UDim2.new(0, 0, 0, 0);
        rightcolumn.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        rightcolumn.Parent = tabcontent;
        
        table.insert(uiElements.scrollbars, rightcolumn);
        
        local rightlayout = Instance.new("UIListLayout");
        rightlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        rightlayout.Padding = UDim.new(0, 12);
        rightlayout.Parent = rightcolumn;
        
        local rightpad = Instance.new("UIPadding");
        rightpad.PaddingLeft = UDim.new(0, 8);
        rightpad.PaddingRight = UDim.new(0, 8);
        rightpad.PaddingTop = UDim.new(0, 8);
        rightpad.PaddingBottom = UDim.new(0, 8);
        rightpad.Parent = rightcolumn;
        
        local tabData = {
            button = tabbtn,
            label = tablbl,
            icon = iconlbl,
            isActive = false
        };
        table.insert(uiElements.tabButtons, tabData);
        
        local function selecttab()
            for _, tab in pairs(window.tabs) do
                createtween(tab.label, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                if tab.icon then
                    createtween(tab.icon, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                end;
                createtween(tab.underline, twinfo.med, {Size = UDim2.new(0, 0, 0, 3)}):Play();
                createtween(tab.hoverline, twinfo.fast, {Size = UDim2.new(0, 0, 0, 2)}):Play();
                tab.content.Visible = false;
                
                for _, tabButtonData in pairs(uiElements.tabButtons) do
                    if tabButtonData.button == tab.button then
                        tabButtonData.isActive = false;
                        break;
                    end;
                end;
            end;
            
            createtween(tablbl, twinfo.med, {TextColor3 = clrs.pink}):Play();
            if iconlbl then
                createtween(iconlbl, twinfo.med, {TextColor3 = clrs.pink}):Play();
            end;
            createtween(underline, twinfo.med, {Size = UDim2.new(0, textbounds.X, 0, 3)}):Play();
            
            tabcontent.Visible = true;
            window.activetab = name;
            
            for _, tabButtonData in pairs(uiElements.tabButtons) do
                if tabButtonData.button == tabbtn then
                    tabButtonData.isActive = true;
                    break;
                end;
            end;
        end;
        
        tabbtn.MouseEnter:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.lightpink}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.lightpink}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, textbounds.X * 0.8, 0, 2)}):Play();
            end;
        end);
        
        tabbtn.MouseLeave:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.darkgrey}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.darkgrey}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, 0, 0, 2)}):Play();
            end;
        end);
        
        tabbtn.MouseButton1Click:Connect(selecttab);
        
        local tab = {
            button = tabbtn,
            label = tablbl,
            icon = iconlbl,
            underline = underline,
            hoverline = hoverline,
            content = tabcontent,
            leftcolumn = leftcolumn,
            rightcolumn = rightcolumn,
            name = name
        };
        
        window.tabs[name] = tab;
        
        if window.activetab == nil then
            selecttab();
        end;
        
        local tabmethods = {};
        tabmethods.content = tabcontent;
        tabmethods.leftcolumn = leftcolumn;
        tabmethods.rightcolumn = rightcolumn;
        
        function tabmethods:CreateBox(cfg)
            local cfg = cfg or {};
            local name = cfg.Name or "Box";
            local column = cfg.Column or "left";
            local height = cfg.Height or 300;
            
            local targetcolumn = column == "right" and rightcolumn or leftcolumn;
            
            local box = Instance.new("ScrollingFrame");
            box.Name = name;
            box.Size = UDim2.new(1, 0, 0, height);
            box.BackgroundColor3 = clrs.secondary;
            box.BackgroundTransparency = 0.05;
            box.BorderSizePixel = 0;
            box.ScrollBarThickness = 2;
            box.ScrollBarImageColor3 = clrs.pink;
            box.ScrollBarImageTransparency = 0.8;
            box.CanvasSize = UDim2.new(0, 0, 0, 0);
            box.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            box.LayoutOrder = #targetcolumn:GetChildren();
            box.Parent = targetcolumn;
            
            createAcrylicBg(box, 0.05);
            
            table.insert(uiElements.scrollbars, box);
            
            local boxcorner = Instance.new("UICorner");
            boxcorner.CornerRadius = UDim.new(0, 12);
            boxcorner.Parent = box;
            
            local boxstroke = Instance.new("UIStroke");
            boxstroke.Color = clrs.pink;
            boxstroke.Thickness = 1;
            boxstroke.Transparency = 0.5;
            boxstroke.Parent = box;
            
            table.insert(uiElements.strokes, boxstroke);
            
            local boxtitle = Instance.new("TextLabel");
            boxtitle.Size = UDim2.new(1, -20, 0, 30);
            boxtitle.Position = UDim2.new(0, 10, 0, 10);
            boxtitle.BackgroundTransparency = 1;
            boxtitle.Text = name;
            boxtitle.TextColor3 = clrs.pink;
            boxtitle.TextSize = 16;
            boxtitle.Font = Enum.Font.GothamBold;
            boxtitle.TextXAlignment = Enum.TextXAlignment.Left;
            boxtitle.ZIndex = 2;
            boxtitle.Parent = box;
            
            table.insert(uiElements.boxTitles, boxtitle);
            
            local boxcontent = Instance.new("ScrollingFrame");
            boxcontent.Size = UDim2.new(1, -20, 1, -50);
            boxcontent.Position = UDim2.new(0, 10, 0, 40);
            boxcontent.BackgroundTransparency = 1;
            boxcontent.BorderSizePixel = 0;
            boxcontent.ScrollBarThickness = 2;
            boxcontent.ScrollBarImageColor3 = clrs.pink;
            boxcontent.ScrollBarImageTransparency = 0.8;
            boxcontent.CanvasSize = UDim2.new(0, 0, 0, 0);
            boxcontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            boxcontent.ZIndex = 2;
            boxcontent.Parent = box;
            
            table.insert(uiElements.scrollbars, boxcontent);
            
            local boxlayout = Instance.new("UIListLayout");
            boxlayout.SortOrder = Enum.SortOrder.LayoutOrder;
            boxlayout.Padding = UDim.new(0, 8);
            boxlayout.Parent = boxcontent;
            
            local boxpad = Instance.new("UIPadding");
            boxpad.PaddingLeft = UDim.new(0, 8);
            boxpad.PaddingRight = UDim.new(0, 8);
            boxpad.PaddingTop = UDim.new(0, 8);
            boxpad.PaddingBottom = UDim.new(0, 8);
            boxpad.Parent = boxcontent;
            
            return boxcontent;
        end;
        
        function tabmethods:AddSeparator()
            local sepframe = Instance.new("Frame");
            sepframe.Size = UDim2.new(1, 0, 0, 15);
            sepframe.BackgroundTransparency = 1;
            sepframe.LayoutOrder = #tabcontent:GetChildren();
            sepframe.Parent = tabcontent;
            
            local sep = Instance.new("Frame");
            sep.Size = UDim2.new(1, -20, 0, 1);
            sep.Position = UDim2.new(0, 10, 0.5, -1);
            sep.BackgroundColor3 = clrs.separator;
            sep.BorderSizePixel = 0;
            sep.Parent = sepframe;
            
            local sepcorner = Instance.new("UICorner");
            sepcorner.CornerRadius = UDim.new(0, 1);
            sepcorner.Parent = sep;
            
            return sepframe;
        end;
        
        return tabmethods;
    end;
    
    return window;
end;

return pnkui;