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
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreemploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi"%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><h3><i class="fa fa-th"></i> R�f�rencer une nouvelle offre emploi</h3></div> <!-- /.panel-heading -->
            <div class="panel-body">
                <%
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

                    IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
                    Offreemploi offreemploi = serviceOffreemploi.nouvelleOffreemploi(nom,descriptif,profilRecherche,secteurActivite);
                %>
                <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            Nouvelle entreprise r�f�renc�e
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
