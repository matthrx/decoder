function vector = HARD_DECODEUR_GROUPE_41(c, H, p, MAX_ITER)
    % p array ligne
    %Initialisation de la matrice q regroupant les réponses de c_i à f_j
    %(voir doc)
    % j sera en réalité le nombre de "check node" et i sera le nombre de
    % v-node
    matrice_q = 
    
    % On stocke uniquement les q(1) // r et q ont la même taille càd c
    matrice_r = zeros(size(c,2), size(c,1));  
    rows_q = zeros(size(c,1)); 
    for x=1:size(matrice_r,1)
       rows_q(x) = x;
    end
    disp(rows_q)
    ite=0;
    while(ite<MAX_ITER)
        
        % Calcul du message de réponse de la part des noeuds. 
        for col=1:size(matrice_r,2)
            for row=1:size(matrice_r,1)
                V_ji = rows_q;
                V_ji(row) = [];
                produit = 1;
                for i_tild=V_ji
                  produit = produit*(1-2*matrice_q(i_tild,col));
                end
                matrice_r(col,row)= 0.5*(1-produit);
               % On stocke que les 1 dans matrice_r
            end
        end
        
        for row=1:size(matrice_q,1)
            for col=1:size(matrice_q,2)
                C_ij = rows
    end
    vector=c;
end

