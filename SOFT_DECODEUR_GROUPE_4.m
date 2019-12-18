function vector = HARD_DECODEUR_GROUPE_4(c, H, p, MAX_ITER)
    %la fonction de d�codage pur
    M = size(c,1);%taille du variable nodes
    N = size(H,1);%nombre de check nodes
    i = 1;
    while(i<MAX_ITER && parity_checked(c, H))%it�ration sur un nombre limite ou tant que notre parit� n'est pas respect�e
        coeff_r=ones(1, M)%op�rations 5&6
        for j = 1:N %On it�re check node par check node        
            for k = 1:M%On it�re au sein de notre check node
               if H(j,k) == 1%Si la check node re�oit un message de la variable node associ�e, on valide
                   array_without_k = setdiff(1:M,k);%on r�cup�re tous les messages des autres variables nodes
                   produit=1
                   for x = array_without_k%on it�re sur les autres variable nodes
                       produit=produit*(1-2*p(x))%formule 3 partielle: probabilit� qu'il y a un nombre pair de 1 en dehors
                       %cette formule marche sans �liminer les 0 car si
                       %p(x)=0 alors notre produit est inchang�
                   end
                   produit=0.5+0.5*produit%fin de la formule 3
                   coeff_r[k]=coeff_r[k]*produit%formule 5&6 partielle: r�ponse re�ue par la variable node                   
               end
            end           
        end
        
        %c'est pas bon parce que on est sens� ignorer la node consern�e
        %dans notre nouvelle r�ponse.
        %gros probl�me innatendu: une vector node peut envoyer des
        %informations diff�rentes � plusieures check nodes
        %conclusion: besoin de faire une matrice de messages � envoyer et
        %faire un produit matriciel
        
        %les check nodes ont fini d'envoyer leurs r�ponse
        q_0=(1-p).*coeff_r%continuation de la formule 5
        q_1=p.*(1-coeff_r)%continuation de la formule 6
        Kij=1./(q_0+q_1)%settings de nos Kij
        q_0=q_0.*Kij%fin de la formule 5
        q_1=q_1.*Kij%fin de la formule 6
        p=q_1
    end
    vector=c;
end