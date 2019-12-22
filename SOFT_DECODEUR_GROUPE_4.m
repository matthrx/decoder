function vector = SOFT_DECODEUR_GROUPE_4(c, H, p, MAX_ITER)
    % c est un vecteur colonne, p est une 
    % constante aussi vecteur colonne
    
    %récupération des informations sur nos données
    lignes_H = size(H,1);
    colonne_c = size(c,1);
    %les messages de nos values nodes vers nos check nodes
    Qij = [];
    iter = 0;
    %initialisation de nos messages envoyés pour correspondre aux
    %probabilités initiales
    for i = 1:lignes_H
        Qij = [Qij;p'];
    end
    
    
    
    %itération tant que notre mot n'est pas décodé ou qu'on a atteint le
    %nombre max d'itérations
    while (iter<MAX_ITER && ~parity_checked(c,H))
        %vérification que l'on envoie des messages uniquement aux bonnes
        %check nodes
        Qij = Qij.*H;
        %initialisation de la réponse de nos check nodes
        Rij_0=[];
        
        %parcours de notre matrice Qij ligne par ligne, ou check node par check node
        for k = 1:lignes_H
            %k=j
            %initialisation des réponses de notre check node
            vecteur_Rij_0 = zeros(1,colonne_c);
            %parcours de notre node élément par élément
            for l = 1:colonne_c
                %l=i
                %vérification que l'on doit traiter notre value node
                if H(k,l) ~= 0
                    produit1 = 1;
                    %récupération des indexes sauf celui de la node traitée
                    %nommé Vj\i dans le papier
                    array_without_k = setdiff(1:colonne_c, l);
                    for m = array_without_k
                        %calcul de notre réponse, rij(0), en fonction des
                        %qij(1)
                        produit1 = produit1*(1-2*Qij(k,m));%formule 3, partie produit
                    end
                    %stockage de nos réponses dans un vecteur
                    vecteur_Rij_0(l) = 0.5+0.5*produit1;%fin de la formule 3
                end
            end
            Rij_0=[Rij_0;vecteur_Rij_0];
        end
        Rij_1=1-Rij_0;
        % Fin calcul de Rij
        %Rij confirmé bon sur un exemple à la main
    
        % Calcul de Q
        %parcours de Rij value node par value node
        for k = 1:colonne_c
            %valeurs pour les formules 7 & 8
            Qi_0=1;
            Qi_1=1;
            %itération de Rij check node par check node
            for l = 1:lignes_H
                produit1 = 1;%qij(1)
                produit0=1;%qij(0)
                
                if H(l,k)~=0%check si les check nodes devaient envoyer une réponse
                    array_without_k = setdiff(1:lignes_H, l); %All nodes except f_j
                    for m = array_without_k
                        if H(m, k)~=0
                            %calcul des produits des formules 5 & 6
                            if H(m,k)~=0
                                produit0=produit0*Rij_0(m,k);%qij(0)
                                produit1=produit1*Rij_1(m,k);%qij(1)
                            end
                        end
                    end
                    %application des probabilités initiales à notre produit
                    produit0=produit0*(1-p(k));
                    produit1=produit1*p(k);
                    Kij=1/(produit0+produit1);%facteur pour que somme des probas=1
                    produit0=produit0*Kij;
                    produit1=produit1*Kij;
                    Qij(l, k)=produit1;%fin de la formule 5
                    
                    %Qij validé par un calcul à la main
                    
                    %mise a jour de notre produit final, sans se préoccuper
                    %des array_without_k
                    Qi_0=Qi_0*Rij_0(l,k);
                    Qi_1=Qi_1*Rij_1(l,k);
                end
            end%fin d'itération sur les colonnes(aka check node)
            
            %fin des formules 7 & 8
            Ki=1/(Qi_0+Qi_1);
            Qi_0=Ki*(1-p(k))*Qi_0;
            Qi_1=Ki*p(k)*Qi_1;
            if Qi_1>Qi_0
                c(k)=1;
            else
               c(k)=0;
            end     
        end
        iter=iter+1;
    end
    vector=c;
end

function parity = parity_checked(c, H)
      % fonction return true si parité n'est pas vérfifée, false sinon
      parity = true;
      test_vector = H*c;
      for x = 1:size(test_vector,1)
          if mod(test_vector(x,1),2)==1
               parity = false;
          end
      end
end
