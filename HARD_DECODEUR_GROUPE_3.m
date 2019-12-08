function vector = HARD_DECODEUR_GROUPE_31(c,H, MAX_ITER)
    disp(c);
    
    ite=0;
    while(ite<MAX_ITER)
        [~,nb_colonnes]=size(H);
        test_vector=H*c;
        index=find(mod(test_vector,2)); %index des elements impairs
        disp(test_vector);
        if isempty(index)==1 %rien ne change
            break
        end
        
        [nb_lignes,~]=size(index);
        
        matrice_parite=zeros(nb_lignes+1,nb_colonnes);
        
        for i=1:nb_lignes
            matrice_parite(i,:) = xor(H(index(i),:),c.');
        end
        
        matrice_parite(nb_lignes+1,:)=c;
        c=round(mean(matrice_parite));
        c=c.';
    end
    vector=c;
end

