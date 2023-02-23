package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import jakarta.ejb.Remote;

@Remote
public interface IServiceQualification {
    public NiveauQualification addNiveauQualification(String name);

    public List<NiveauQualification> findAll();

}
