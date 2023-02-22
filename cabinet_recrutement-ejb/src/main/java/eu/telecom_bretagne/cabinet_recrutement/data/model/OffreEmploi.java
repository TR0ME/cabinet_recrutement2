package eu.telecom_bretagne.cabinet_recrutement.data.model;
// Generated Feb 2, 2023, 2:41:08 PM by Hibernate Tools 5.4.20.Final


import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import jakarta.persistence.*;

/**
 * OffreEmploi generated by hbm2java
 */
@Entity
@Table(name = "offre_emploi"
        , schema = "public"
)
public class OffreEmploi implements java.io.Serializable {


    private int idOffre;
    private NiveauQualification niveauQualification;
    private String titre;
    private String descriptif;
    private String profilRecherche;
    private Date dateDepot;
    //private Integer noEntreprise;

    private Entreprise entreprise;
    private Set<MessageCandidat> messageCandidats = new HashSet<MessageCandidat>(0);
    private Set<MessageOffreemploi> messageOffreemplois = new HashSet<MessageOffreemploi>(0);
    private Set<SecteurActivite> secteurActivites = new HashSet<SecteurActivite>(0);

    public OffreEmploi() {
    }


    public OffreEmploi(int idOffre) {
        this.idOffre = idOffre;
    }

    public OffreEmploi(int idOffre, NiveauQualification niveauQualification, String titre, String descriptif, String profilRecherche, Date dateDepot, Entreprise entreprise, Set<MessageCandidat> messageCandidats, Set<MessageOffreemploi> messageOffreemplois, Set<SecteurActivite> secteurActivites) {
        this.idOffre = idOffre;
        this.niveauQualification = niveauQualification;
        this.titre = titre;
        this.descriptif = descriptif;
        this.profilRecherche = profilRecherche;
        this.dateDepot = dateDepot;
        this.entreprise = entreprise;
        this.messageCandidats = messageCandidats;
        this.messageOffreemplois = messageOffreemplois;
        this.secteurActivites = secteurActivites;
    }

    public OffreEmploi(String titre, String descriptif, String profilRecherche, NiveauQualification niveauQualification, Date dateDepot, Entreprise entreprise) {
        this.niveauQualification = niveauQualification;
        this.titre = titre;
        this.descriptif = descriptif;
        this.profilRecherche = profilRecherche;
        this.dateDepot = dateDepot;
        this.entreprise = entreprise;
        //this.messageOffreemplois = messageOffreemplois;
        //this.secteurActivites = secteurActivites;
    }

    public OffreEmploi(String titre, String descriptif, String profilRecherche, List<SecteurActivite> secteurActivites, NiveauQualification niveauQualification, Entreprise entreprise){
        this.titre = titre;
        this.descriptif = descriptif;
        this.profilRecherche = profilRecherche;
        Set<SecteurActivite> sects = new HashSet<>(secteurActivites);
        this.secteurActivites = sects;
        this.niveauQualification = niveauQualification;
        this.entreprise = entreprise;
    }

    public OffreEmploi(Date dateDepot, String mission, String profilRecherche, String titre, Entreprise entrepirse, NiveauQualification nq){
        this.dateDepot = dateDepot;
        this.descriptif = mission;
        this.profilRecherche = profilRecherche;
        this.entreprise = entrepirse;
        this.niveauQualification = nq;
    }



    @Id
    @Column(name = "id_offre", unique = true, nullable = false)
    @SequenceGenerator(name = "OFFRE_EMPLOI_ID_GENERATOR", sequenceName = "OFFRE_EMPLOI_ID_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OFFRE_EMPLOI_ID_GENERATOR")
    public int getIdOffre() {
        return this.idOffre;
    }

    public void setIdOffre(int idOffre) {
        this.idOffre = idOffre;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "no_qualification")
    public NiveauQualification getNiveauQualification() {
        return this.niveauQualification;
    }

    public void setNiveauQualification(NiveauQualification niveauQualification) {
        this.niveauQualification = niveauQualification;
    }


    @Column(name = "titre")
    public String getTitre() {
        return this.titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }


    @Column(name = "descriptif")
    public String getDescriptif() {
        return this.descriptif;
    }

    public void setDescriptif(String descriptif) {
        this.descriptif = descriptif;
    }


    @Column(name = "profil_recherche")
    public String getProfilRecherche() {
        return this.profilRecherche;
    }

    public void setProfilRecherche(String profilRecherche) {
        this.profilRecherche = profilRecherche;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "date_depot", length = 13)
    public Date getDateDepot() {
        return this.dateDepot;
    }

    public void setDateDepot(Date dateDepot) {
        this.dateDepot = dateDepot;
    }

    @ManyToOne
    @JoinColumn(name = "id_entreprise")
    public Entreprise getEntreprise() {
        return this.entreprise;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "offreEmploi")
    public Set<MessageCandidat> getMessageCandidats() {
        return this.messageCandidats;
    }

    public void setMessageCandidats(Set<MessageCandidat> messageCandidats) {
        this.messageCandidats = messageCandidats;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "offreEmploi")
    public Set<MessageOffreemploi> getMessageOffreemplois() {
        return this.messageOffreemplois;
    }

    public void setMessageOffreemplois(Set<MessageOffreemploi> messageOffreemplois) {
        this.messageOffreemplois = messageOffreemplois;
    }

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "secteur_offre", schema = "public", joinColumns = {
            @JoinColumn(name = "no_offre", nullable = false, updatable = false)}, inverseJoinColumns = {
            @JoinColumn(name = "no_secteur", nullable = false, updatable = false)})
    public Set<SecteurActivite> getSecteurActivites() {
        return this.secteurActivites;
    }

    public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
        this.secteurActivites = secteurActivites;
    }


    public String toStringShort() {
        return "OffreEmploi[Titre=" + this.titre + ", descriptif=" + this.descriptif + ", descriptif=" + this.descriptif + "]";
    }

    public MessageCandidat removeMessageCandidat(MessageCandidat messageCandidat) {
        getMessageCandidats().remove(messageCandidat);
        messageCandidat.setOffreEmploi(null);

        return messageCandidat;
    }

    public MessageOffreemploi removeMessageOffredemploi(MessageOffreemploi messageOffreemploi) {
        getMessageOffreemplois().remove(messageOffreemploi);
        messageOffreemploi.setOffreEmploi(null);

        return messageOffreemploi;
    }

}


