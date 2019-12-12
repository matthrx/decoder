function vector = HARD_DECODEUR_GROUPE_41(c, H, p, MAX_ITER)
    % p array de la même taille de c et correspond à la probabilité de c_i
    % = 1
    matrice_q = p
    % On stocke uniquement les q(1)
    matrice_r = c 
    rows_q = []
    
    for x=1:size(matrice_r,1)
       rows_q(x) = x
    end
    disp(rows_q)
    ite=0;
    while(ite<MAX_ITER)
        for row=1:size(matrice_r,1)
            Vj_i = rows_q
            Vj_i(row) = []
            produit = 1
            for col=1:size(matrice_r,2)
               for i_tild=Vj_i:
                  produit = produit*(1-2*matrice_q(i_tild,col))
               end
               matrice_r(row,col)= 0.5*(1-produit)
               % On stocke que les 1 dans matrice_r
            end
        end
        
        matrice_parite(nb_lignes+1,:)=c;
        c=round(mean(matrice_parite));
        c=c.';
    end
    vector=c;
end

