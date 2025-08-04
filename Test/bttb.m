function B = bttb(block_first_row, block_first_col)
    % Determine the number of block rows and columns
    n_block_rows = length(block_first_col);
    n_block_cols = length(block_first_row);
    
    % Verify the first block matches
    if ~isequal(block_first_row{1}, block_first_col{1})
        error('First block of row and column must be identical.');
    end
    
    % Initialize cell array for blocks
    B_blocks = cell(n_block_rows, n_block_cols);
    
    % Populate the block matrix
    for i = 1:n_block_rows
        for j = 1:n_block_cols
            k = i - j;
            if k >= 0
                idx = k + 1;
                if idx > length(block_first_row)
                    error('Insufficient blocks in the first row.');
                end
                B_blocks{i,j} = block_first_row{idx};
            else
                idx = -k + 1;
                if idx > length(block_first_col)
                    error('Insufficient blocks in the first column.');
                end
                B_blocks{i,j} = block_first_col{idx};
            end
        end
    end
    
    % Convert cell array to numeric matrix
    B = cell2mat(B_blocks);
end