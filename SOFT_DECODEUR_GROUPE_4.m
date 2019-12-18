

function vector = HARD_DECODEUR_GROUPE_4(c, H, p, MAX_ITER)
   %test
    M = size(c,1);
    N = size(H,1);
    i = 1;
    %while(i<MAX_ITER && parity_checked(c, H))
        p_bis=[];
        
        for j = 1:M %On it�re dans le mot code re�u
            
            coeff_r = []; % A chaque 
            coeff_r(1) = p(j); %Aucune autre information dispo, initialisation
            
            for k = 1:N
               % On checke que le noeud est bien un noeud de v�rification afin 
               % d'en d�duire que l'on va recevoir un message (page 4)
               if H(k,j) == 1
                  produit = 1;
                  array_without_k = setdiff(1:N,k); % On a donc Vj\i et donc i'

                  for x = array_without_k
                        if H(k,x) == 1 % On r�inspecte qu'un message sera re�u en ce noeud
                            produit = produit*(1-2*p(x)); % On applique une partie de la formule 3
                        end
                  end
                  coeff_r = [coeff_r 0.5*(1-produit)]; %On stocke tous les coeffs calcul�s � l'it�ration j (mot code)
               end
            end
            
            q_1 = p(j)*prod(coeff_r);
            q_0 = (1-p(j))*prod(1-coeff_r);
            
            p_bis(j) = q_1/(q_1+q_0); %Formule 5 et 6
            
            
            if (q_1/(q_0+q_1) > 0.5)
                c(j) = 0;
            else
                c(j)=1;
            end
            disp value_of_p
            disp(j)
            disp(p_bis(j))
            
        end
        disp pbis
        disp(p_bis)
        %Fin d'it�ration, autre condition pour quit ? - On actualise 
        p = p_bis;
        % si le nouveau mot code remplit la condition de parit� over sinon
        % on r�it�re (while)
    %end
    vector=c;
end

function parity = parity_checked(c, H)
      % fonction return true si parit� n'est pas v�rfif�e, false sinon
      parity = true;
      test_vector = H*c;
      if mod(test_vector, 2) ~= zeros(size(test_vector,1), size(test_vector,2))
          parity = false;
      
      end
end
