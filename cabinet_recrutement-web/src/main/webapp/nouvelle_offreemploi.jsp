<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 22/02/2023
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi"%>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="java.util.List" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteur" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO" %>
<%@ page import="java.util.Set" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.*" %>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><h3><i class="fa fa-th"></i> R�f�rencer une nouvelle offre emploi</h3></div> <!-- /.panel-heading -->
            <div class="panel-body">
                <%
                    IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
                    List<Candidat> candidatures = serviceCandidat.listeCandidat();

                    List<NiveauQualification> niveauqualif = serviceCandidat.listeNiveauQualification();
                    List<SecteurActivite> secteurActs = serviceCandidat.listeSecteurs();
                    IServiceSecteur serviceSecteur = (IServiceSecteur) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");

                    String nom = request.getParameter("nom");
                    if(nom == null) // Pas de param�tre "nom" => affichage du formulaire
                    {
                %>
                <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
                    <form role="form" action="template.jsp" method="get">
                        <input type="hidden" name="action" value="nouvelle_offreemploi" />
                        <div class="form-group">
                            <input class="form-control" placeholder="Nom de l'offre emploi" name="nom" />
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" placeholder="Descriptif de l'offre d'emploi" rows="5" name="descriptif"></textarea>
                        </div>
                        <div class="form-group">
                            <input class="form-control" placeholder="Profile recherche" name="description_profile_recherche" />
                        </div>
                        <div class="form-group">
                            <input class="form-control" placeholder="Secteur d'activite" name="secteur_activite" />
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Niveau de qualification</label>
                                <small>
                                    <% for(NiveauQualification nq : niveauqualif){%>

                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="niveau" value="<%=nq.getIdQualification()%>" /><%=nq.getIntituleQualification() %>
                                        </label>
                                    </div>
                                    <%} %>
                                </small>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <div class="form-group">
                                <label>Secteur(s) d'activité</label>
                                <small>
                                    <table border="0" width="100%">
                                        <!-- Un petit système à la volée pour mettre les checkboxes en deux colonnes...  -->
                                        <%
                                            int i=0;
                                            for(SecteurActivite s : secteurActs) {
                                                i++;
                                                if(i%2 == 0) {%>

                                        <td>
                                            <input type="checkbox" name="secteur" value="<%=s.getIdSecteur()%>" /><%=s.getIntituleActivite()%>
                                        </td>
                                        </tr>
                                        <%} else{%>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="secteur" value="<%=s.getIdSecteur()%>" /><%=s.getIntituleActivite()%>
                                            </td>

                                            <%} %>
                                            <%}
                                                if(i%2==1) { %>
                                        </tr>
                                        <%
                                            }
                                        %>

                                    </table>
                                </small>
                            </div>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
                            <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                        </div>
                    </form>
                </div>
                <%
                }
                else // Param�tre "nom" existant => stockage des donn�es et affichage du r�sultat
                {
                    if(nom.equals(""))
                    {
                %>
                <div class="row col-xs-offset-1 col-xs-10">
                    <div class="panel panel-red">
                        <div class="panel-heading ">
                            Impossible de traiter la demande
                        </div>
                        <div class="panel-body text-center">
                            <p class="text-danger"><strong>Il n'est pas possible de referencer une offre emploi qui ne possede pas de nom.</strong></p>
                        </div>
                    </div>
                </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
                <%
                }
                else
                {
                    // R�cup�ration des autres param�tres
                    String descriptif     = request.getParameter("descriptif");
                    String profile_recherche = request.getParameter("profile_recherche");
                    String secteur_activite = request.getParameter("secteur_activite");
                    String profilRecherche = request.getParameter("description_profile_recherche");
                    NiveauQualification nq = serviceCandidat.findNQByID(Integer.parseInt(request.getParameter("niveau")));

                    List<SecteurActivite> secteurActivite = (List<SecteurActivite>) serviceSecteur.getSecteurActivite(Integer.parseInt(request.getParameter("secteur")));

                    IServiceOffreEmploi serviceOffreemploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
                    Entreprise entreprise = (Entreprise) session.getAttribute("utilisateur");
                    OffreEmploi offreemploi = serviceOffreemploi.nouvelleOffreEmploi(nom,descriptif,profilRecherche,secteurActivite, nq, entreprise);
                    //nouvelleOffreEmploi(String titre,String descriptif,String profilRecherche,List<SecteurActivite> secteurActivite, NiveauQualification niveauQualification, Entreprise entreprise);
                %>
                <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            Nouvelle offre Emploi
                        </div>
                        <div class="panel-body">
                            <small>
                                <table class="table">
                                    <tbody>
                                    <tr class="success">
                                        <td><strong>Identifiant (login)</strong></td>
                                        <td>ENT_<%=entreprise.getId()%></td>
                                    </tr>
                                    <tr class="warning">
                                        <td><strong>Nom</strong></td>
                                        <td><%=entreprise.getNom()%></td>
                                    </tr>
                                    <tr class="warning">
                                        <td><strong>Adresse postale (ville)</strong></td>
                                        <td><%=entreprise.getAdressePostale()%></td>
                                    </tr>
                                    <tr class="warning">
                                        <td><strong>Descriptif</strong></td>
                                        <td><%=Utils.text2HTML(entreprise.getDescriptif())%></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </small>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div> <!-- /.panel-body -->
        </div> <!-- /.panel -->
    </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
