package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import jakarta.ejb.Remote;

/**
 * Iterface gérant les niveax de qualifications
 * @author Mathieu Bourges
 * @author Laure Andro
 */
@Remote
public interface IServiceQualification {

    /**
     * Methode qui permet l'ejout d'un niveau de qualification dans la BDD
     * @param name
     * @return
     */
    public NiveauQualification addNiveauQualification(String name);

    /**
     * Methode qui permet de retrouver tous les niveaux de qualifications dans la BDDs
     * @return
     */
    public List<NiveauQualification> findAll();

}
