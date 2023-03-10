package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

// import javax.ejb.EJB;
// import javax.ejb.LocalBean;
// import javax.ejb.Stateless;
// import javax.jws.WebService;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;

/**
 * Session Bean implementation class ServiceEntreprise
 *
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceEntreprise implements IServiceEntreprise {
    //-----------------------------------------------------------------------------
    @EJB
    private EntrepriseDAO entrepriseDAO;
    //-----------------------------------------------------------------------------

    /**
     * Default constructor.
     */
    public ServiceEntreprise() {
        // TODO Auto-generated constructor stub
    }

    //-----------------------------------------------------------------------------
    @Override
    public Entreprise getEntreprise(int id) {
        return entrepriseDAO.findById(id);
    }

    //-----------------------------------------------------------------------------

    public Entreprise execUpdate(Entreprise entreprise){
        return entrepriseDAO.update(entreprise);
    }
    @Override
    public List<Entreprise> listeDesEntreprises() {
        return entrepriseDAO.findAll();
    }

    @Override
    public Entreprise nouvelleEntreprise(String nom, String descriptif, String adressePostale) {
        Entreprise entreprise = new Entreprise(adressePostale, descriptif, nom);
        entrepriseDAO.persist(entreprise);
        return entreprise;
    }
    //-----------------------------------------------------------------------------
}
