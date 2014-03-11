function [imgOut, patternOut] = stipple(imgIn, ...
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
    %----------------------------------------------------------------------
    
    % intensity thresholds; assume pixel intensity values [0..1]
    INTENSITY_DARKER = 0.2;
    INTENSITY_DARK = 0.4;
    INTENSITY_LIGHT = 0.6;
    INTENSITY_LIGHTER = 0.8;
    INTENSITY_LIGHTEST = 1.0;
    
    close all;    
    
    imgOut = ones(size(imgIn, 1), size(imgIn, 2));
    patternOut = zeros(floor(size(imgIn, 1) / windowHeight - 1), ...
                       floor(size(imgIn, 2) / windowWidth - 1));
        
    for currentRowInPattern = 1:size(patternOut, 1)
        for currentColInPattern = 1:size(patternOut, 2)
            windowRowStart = currentRowInPattern * windowHeight;
            windowRowEnd = windowRowStart + windowHeight;
            windowColStart = currentColInPattern * windowWidth;
            windowColEnd = windowColStart + windowWidth;
            windowImg = imgIn(windowRowStart:windowRowEnd, ...
                              windowColStart:windowColEnd);
            windowAvgIntensity = mean2(windowImg); 
            horizontalPadding = 0;
            verticalPadding = 0;
            
            if windowAvgIntensity <= INTENSITY_DARKER
                horizontalPadding = 1;
                verticalPadding = 1;                
                patternVal = INTENSITY_DARKER;
            elseif windowAvgIntensity <= INTENSITY_DARK
                horizontalPadding = 2;
                verticalPadding = 2;  
                patternVal = INTENSITY_DARK;
            elseif windowAvgIntensity <= INTENSITY_LIGHT
                horizontalPadding = 3;
                verticalPadding = 3;                
                patternVal = INTENSITY_LIGHT;
            elseif windowAvgIntensity <= INTENSITY_LIGHTER
                horizontalPadding = 4;
                verticalPadding = 4;                            
                patternVal = INTENSITY_LIGHTER;
            else                
                patternVal = INTENSITY_LIGHTEST;                
            end
                        
            patternOut(currentRowInPattern, currentColInPattern) = patternVal;  

            if patternVal ~= INTENSITY_LIGHTEST
                imgOut((windowRowStart + verticalPadding): ...
                       (windowRowStart + verticalPadding + ...
                        windowHeight - (2 * verticalPadding)), ...
                       (windowColStart + horizontalPadding): ...
                       (windowColStart + horizontalPadding + ...
                        windowWidth - (2 * horizontalPadding))) = 0;
            end
        end
    end                       
end

