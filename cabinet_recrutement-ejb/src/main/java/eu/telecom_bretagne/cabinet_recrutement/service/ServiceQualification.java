package eu.telecom_bretagne.cabinet_recrutement.service;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;

import java.util.List;

/**
 * @author Mathieu Bourges
 * @author Laure Andro
 */
@Stateless
@LocalBean
public class ServiceQualification implements IServiceQualification {


    @EJB
    private NiveauQualificationDAO niveauQualificationDAO;

    @Override
    public NiveauQualification addNiveauQualification(String name) {
        return niveauQualificationDAO.persist(name);
    }

    @Override
    public List<NiveauQualification> findAll() {

        return (List<NiveauQualification>) niveauQualificationDAO.findAll();
    }

}
