function parity = parity_checked(c, H)
      % fonction return true si parité n'est pas vérfifée, false sinon
      parity = true;
      test_vector = H*c;
      if mod(test_vector, 2) ~= zeros(size(test_vector,1), size(test_vector,2))
          parity = false;
      
      end
end

function vector = HARD_DECODEUR_GROUPE_41(c, H, p, MAX_ITER)
   
    M = size(c,1);
    N = size(H,1);
    i = 0;
    while(i<MAX_ITER && ~parity_not_checked(c, H))
        
        for j = 1:M %On itère dans le mot code reçu
            coeff_r = []; % A chaque 
            coeff_r(1) = p(j); %Aucune autre information dispo, initialisation
            
            for k = 1:N
               % On checke que le noeud est bien un noeud de vérification afin 
               % d'en déduire que l'on va recevoir un message (page 4)
               if H(k,j) == 1
                  produit = 1;
                  array_without_k = setdiff(1:N,k); % On a donc Vj\i et donc i'
                  for l = array_without_k
                        if H(k,l) == 1 % On réinspecte qu'un message sera reçu en ce noeud
                            produit = produit*(1-2*p(l)); % On applique une partie de la formule 3
                        end
                  end
                  coeff_r = [coeff_r 0.5*(1-produit)]; %On stocke tous les coeffs calculés à l'itération j (mot code)
               end
            end 
            q_1 = p(j)*prod(coeff_r);
            p_bis(i) = q_1/(q_1+q_0); %Formule 5 et 6
            q_0 = (1-p(j))*prod(1-coeff_r);
            if (q_1/(q_0+q_1) > 0.5)
                c(i) = 0;
            else
                c(i)=1;
            end
        end
        %Fin d'itération, autre condition pour quit ? - On actualise 
        p = p_bis;
        % si le nouveau mot code remplit la condition de parité over sinon
        % on réitère (while)
    end
    vector=c;
end

