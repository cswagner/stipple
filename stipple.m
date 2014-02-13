function [pixelatedImgOut, patternOut] = stipple(imgIn, ...
                                                 windowWidth, ...
                                                 windowHeight)
    %STIPPLE transforms image into "stipple" pattern
    %----------------------------------------------------------------------
    %   transforms an image into a pattern simulating varying degrees of 
    %   solidarity or shading by using rectangles of varying sizes
    %   
    %   Input:
    %       imgIn - input gray-scale image
    %       windowWidth - width of mean convolution filter
    %       windowHeight - height of mean convolution filter
    %   Output:
    %       pixelatedImgOut - pixelated copy of imgIn
    %       patternOut - stipple pattern
    %   Side-Effects:
    %       - closes all open figures
    %       - opens a new image figure to construct stipple image
    %----------------------------------------------------------------------
    
    % intensity thresholds; assume pixel intensity values [0..1]
    INTENSITY_DARKER = 0.2;
    INTENSITY_DARK = 0.4;
    INTENSITY_LIGHT = 0.6;
    INTENSITY_LIGHTER = 0.8;
    INTENSITY_LIGHTEST = 1.0;
    
    close all;    
    
    pixelatedImgOut = ones(size(imgIn, 1), size(imgIn, 2));
    patternOut = zeros(size(imgIn, 1) / windowHeight - 1, ...
                       size(imgIn, 2) / windowWidth - 1);
                   
    hold on;
    imshow(pixelatedImgOut);
        
    for currentRowInPattern = 1:size(patternOut, 1)
        for currentColInPattern = 1:size(patternOut, 2)
            windowRowStart = currentRowInPattern * windowHeight;
            windowRowEnd = windowRowStart + windowHeight;
            windowColStart = currentColInPattern * windowWidth;
            windowColEnd = windowColStart + windowWidth;
            windowImg = imgIn(windowRowStart:windowRowEnd, ...
                              windowColStart:windowColEnd);
            windowAvgIntensity = mean2(windowImg);            
            
            if windowAvgIntensity <= INTENSITY_DARKER
                horizontalPadding = 1;
                verticalPadding = 1;
                rectangle('Position', [windowColStart + horizontalPadding, ...
                                       windowRowStart + verticalPadding, ... 
                                       windowWidth - (2 * horizontalPadding), ...
                                       windowHeight - (2 * verticalPadding)], ...
                          'FaceColor', [0.0 0.0 0.0], ...
                          'LineStyle', 'none'); 
                
                patternVal = INTENSITY_DARKER;
            elseif windowAvgIntensity <= INTENSITY_DARK
                horizontalPadding = 2;
                verticalPadding = 2;                
                rectangle('Position', [windowColStart + horizontalPadding, ...
                                       windowRowStart + verticalPadding, ... 
                                       windowWidth - (2 * horizontalPadding), ...
                                       windowHeight - (2 * verticalPadding)], ...
                          'FaceColor', [0.0 0.0 0.0], ...
                          'LineStyle', 'none');
                
                patternVal = INTENSITY_DARK;
            elseif windowAvgIntensity <= INTENSITY_LIGHT
                horizontalPadding = 3;
                verticalPadding = 3;
                rectangle('Position', [windowColStart + horizontalPadding, ...
                                       windowRowStart + verticalPadding, ... 
                                       windowWidth - (2 * horizontalPadding), ...
                                       windowHeight - (2 * verticalPadding)], ...
                          'FaceColor', [0.0 0.0 0.0], ...
                          'LineStyle', 'none');
                
                patternVal = INTENSITY_LIGHT;
            elseif windowAvgIntensity <= INTENSITY_LIGHTER
                horizontalPadding = 4;
                verticalPadding = 4;
                rectangle('Position', [windowColStart + horizontalPadding, ...
                                       windowRowStart + verticalPadding, ... 
                                       windowWidth - (2 * horizontalPadding), ...
                                       windowHeight - (2 * verticalPadding)], ...
                          'FaceColor', [0.0 0.0 0.0], ...
                          'LineStyle', 'none');
                
                patternVal = INTENSITY_LIGHTER;
            else                
                patternVal = INTENSITY_LIGHTEST;                
            end
                        
            patternOut(currentRowInPattern, currentColInPattern) = patternVal;            
            pixelatedImgOut(windowRowStart:windowRowEnd, ...
                            windowColStart:windowColEnd) = windowAvgIntensity;
        end
    end
    
    hold off;
end

