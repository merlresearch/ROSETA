% Copyright (C) 2017-2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function y = vec(X)
% y = vec(X)
% generates column vector y from a matrix X

y = reshape(X,numel(X),1);
