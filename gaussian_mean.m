function Sigma=gaussian_mean(V, w, Sigma0)
% size(V) = [d*d, n]
% size(w) = [m, n]
% size(Sigma) = [d*d, m]

d=sqrt(size(V,1));
assert(size(V,1) == d*d);
n=size(V,2);
assert(n == size(w, 2))
m=size(w,1);
w = bsxfun(@times, w, 1./sum(w, 2));

Sigma=Sigma0;
Sigma=reshape(Sigma, [d d m]);
old_Sigma=zeros(d, d, m);
V=reshape(V, [d d n]);
while (max(abs(old_Sigma(:) - Sigma(:))) > 1E-4)
old_Sigma = Sigma;
Sigma=zeros(d, d, m);
for i=1:n
    mem=sqrtm(V(:,:,i));
    for j=1:m
        Sigma(:,:,j) = Sigma(:,:,j) + w(j,i) * sqrtm(mem * old_Sigma(:,:,j) * mem);
    end
end
end

Sigma=reshape(Sigma, [d*d, m]);