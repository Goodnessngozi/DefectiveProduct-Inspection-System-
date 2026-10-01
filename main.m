function main()
    % Main Figure Setup
    fig = uifigure('Name', 'Product Inspection System', 'Position', [100, 100, 850, 600]);
    
    % % Shared variables to pass data between buttons
    img = []; 
    
    % ==========================================
    % UI COMPONENTS LAYOUT (Matching Screenshot)
    % ==========================================
    
    % Title Label
    lblTitle = uilabel(fig);
    lblTitle.Text = 'PRODUCT INSPECTION SYSTEM';
    lblTitle.FontSize = 24;
    lblTitle.FontWeight = 'bold';
    lblTitle.BackgroundColor = [0 1 1]; % Cyan
    lblTitle.FontColor = [0 0 0]; % Black
    lblTitle.HorizontalAlignment = 'center';
    lblTitle.Position = [175, 520, 500, 40];
    
    % Upload Image Button
    btnUpload = uibutton(fig, 'push');
    btnUpload.Text = 'Upload Image';
    btnUpload.FontSize = 14;
    btnUpload.FontWeight = 'bold';
    btnUpload.BackgroundColor = [0 0 0]; % Black
    btnUpload.FontColor = [1 1 1]; % White
    btnUpload.Position = [150, 440, 150, 40];
    btnUpload.ButtonPushedFcn = @(btn,event) uploadImage();
    
    % Save Result Button
    btnSave = uibutton(fig, 'push');
    btnSave.Text = 'Save Result';
    btnSave.FontSize = 14;
    btnSave.FontWeight = 'bold';
    btnSave.BackgroundColor = [0 0 0]; % Black
    btnSave.FontColor = [1 1 1]; % White
    btnSave.Position = [350, 400, 150, 40];
    btnSave.ButtonPushedFcn = @(btn,event) saveResult();
    btnSave.Enable = 'off'; % Disabled until an inspection runs
    
    % Inspect Product Button
    btnInspect = uibutton(fig, 'push');
    btnInspect.Text = 'Inspect Product';
    btnInspect.FontSize = 14;
    btnInspect.FontWeight = 'bold';
    btnInspect.BackgroundColor = [0 0 0]; % Black
    btnInspect.FontColor = [1 1 1]; % White
    btnInspect.Position = [550, 440, 150, 40];
    btnInspect.ButtonPushedFcn = @(btn,event) inspectProduct();
    btnInspect.Enable = 'off'; % Disabled until an image is loaded
    
    % Original Axes (Left)
    axOriginal = uiaxes(fig);
    axOriginal.Title.String = 'OriginalAxes';
    axOriginal.Position = [50, 150, 350, 220];
    axOriginal.XColor = 'none'; % Hide tick marks
    axOriginal.YColor = 'none';
    
    % Processed Axes (Right)
    axProcessed = uiaxes(fig);
    axProcessed.Title.String = 'ProcessedAxes';
    axProcessed.Position = [450, 150, 350, 220];
    axProcessed.XColor = 'none'; % Hide tick marks
    axProcessed.YColor = 'none';
    
    % Result Label (Bottom)
    lblResult = uilabel(fig);
    lblResult.Text = 'ResultLabel';
    lblResult.FontSize = 18;
    lblResult.FontWeight = 'bold';
    lblResult.BackgroundColor = [0 0 0]; % Black
    lblResult.FontColor = [0 1 1]; % Cyan
    lblResult.HorizontalAlignment = 'center';
    lblResult.Position = [300, 50, 250, 50];
    
    % ==========================================
    % CALLBACK FUNCTIONS (Image Processing Logic)
    % ==========================================
    
    function uploadImage()
        % 1. Open file dialog for the user to select an image
        [file, path] = uigetfile({'*.jpg;*.png;*.jpeg', 'Image Files'});
        if isequal(file, 0)
            return; % User canceled
        end
        
        % 2. Read and display the image
        img = imread(fullfile(path, file));
        imshow(img, 'Parent', axOriginal);
        axOriginal.Title.String = 'Original Image';
        
        % 3. Reset the processed side and labels
        cla(axProcessed);
        axProcessed.Title.String = 'ProcessedAxes';
        lblResult.Text = 'Ready for Inspection';
        lblResult.FontColor = [0 1 1]; % Reset to Cyan
        
        % 4. Enable the Inspect button
        btnInspect.Enable = 'on';
        btnSave.Enable = 'off';
    end

    function inspectProduct()
        if isempty(img)
            return;
        end
        
        % 1. Convert to Grayscale & Detect Edges
        gray = rgb2gray(img);
        edges = edge(gray, 'Canny');
        stats = regionprops(edges, 'BoundingBox', 'Area');
        
        % 2. Show the base image on the right axes
        imshow(img, 'Parent', axProcessed);
        axProcessed.Title.String = 'Detected Defect';
        hold(axProcessed, 'on');
        
        % 3. Draw Red Bounding Boxes for defects
        for k = 1:length(stats)
            if stats(k).Area > 50
                rectangle('Parent', axProcessed, ...
                          'Position', stats(k).BoundingBox, ...
                          'EdgeColor', 'red', ...
                          'LineWidth', 2);
            end
        end
        
        % 4. Classification Logic
        numEdges = sum(edges(:));
        threshold = 8000;
        
        if numEdges > threshold
            resultText = "BAD PRODUCT";
            lblResult.FontColor = [1 0 0]; % Turn label text Red
        else
            resultText = "GOOD PRODUCT";
            lblResult.FontColor = [0 1 0]; % Turn label text Green
        end
        
        % 5. Update UI Text
        lblResult.Text = resultText;
        
        % Draw text directly on the processed image
        text(axProcessed, 20, 40, resultText, ...
            'Color', 'blue', ...
            'FontSize', 18, ...
            'FontWeight', 'bold');
            
        hold(axProcessed, 'off');
        
        % Enable the Save button
        btnSave.Enable = 'on';
    end

    function saveResult()
        % 1. Open file dialog to choose save location
        [file, path] = uiputfile({'*.jpg;*.png', 'Image Files'}, 'Save Processed Image As');
        if isequal(file, 0)
            return; % User canceled
        end
        
        % 2. Export the processed axes (captures image + red boxes + blue text)
        exportgraphics(axProcessed, fullfile(path, file), 'Resolution', 300);
        
        % Optional: Notify user
        lblResult.Text = 'Image Saved Successfully!';
    end

end % <--- THIS IS THE CLOSING "END" FOR THE MAIN FUNCTION. DO NOT MISS THIS.