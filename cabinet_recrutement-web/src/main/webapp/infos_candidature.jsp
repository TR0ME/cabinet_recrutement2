<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 24/02/2023
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>

<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification" %>
<%@ page import="java.util.Set" %>
<%
    IServiceCandidat serviceCandidat = null;



    try {
        serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
    } catch (Exception e) {
%>
<h4>[ERROR] lors de l'initialisation de service Candidat</h4>
<%
    }
    String erreur = null;
    String idStringValue = request.getParameter("id");
    int id = -1;
    Candidat candidature = null;

    if (idStringValue == null) {
        erreur = "Aucun identifiant de candidature n'est fourni dans la demande.";
    } else {
        try {
            id = Integer.parseInt(idStringValue);
            // C'est OK : on a bien un id
            IServiceCandidat serviceEntreprise = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
            candidature = serviceEntreprise.getCandidat(id);
            if (candidature == null) {
                erreur = "Aucune candidature ne correspond à cet identifiant : " + id;
            }
        } catch (NumberFormatException e) {
            erreur = "La valeur de l'identifiant n'est pas numérique";
        }
    }
%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur la candidature</h3></div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <%
                    if (erreur != null) // Une erreur a été détectée et est affichée.
                    {
                %>
                <div class="row col-xs-offset-1 col-xs-10">
                    <div class="panel panel-red">
                        <div class="panel-heading ">
                            Impossible de traiter la demande
                        </div>
                        <div class="panel-body text-center">
                            <p class="text-danger"><strong><%=erreur%>
                            </strong></p>
                        </div>
                    </div>
                </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
                <%
                } else {
                %>
                <div class="table-responsive">
                    <small>
                        <table class="table">
                            <tbody>
                            <tr class="success">
                                <td width="200"><strong>Identifiant (login)</strong></td>
                                <td>CAND_<%=candidature.getIdCandidat()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td width="200"><strong>Nom</strong></td>
                                <td><%=candidature.getNom()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td width="200"><strong>Prenom</strong></td>
                                <td><%=candidature.getPrenom()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Adresse postale</strong></td>
                                <td><%=candidature.getAdressePostale()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Adresse email</strong></td>
                                <td><%=candidature.getAdresseEmail()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Date de naissance</strong></td>
                                <td><%=candidature.getDateNaissance()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Niveau qualification</strong></td>
                                <td><%=serviceCandidat.afficherNQ(candidature)%></td>

                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Secteur activite</strong></td>
                                <td><%=serviceCandidat.GetSecteursString(candidature)%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Date de depot</strong></td>
                                <td><%=candidature.getDateDepot()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>CV</strong></td>
                                <td><%=candidature.getCv()%>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </small>
                </div>
                <%
                    }
                %>
            </div> <!-- /.panel-body -->
        </div> <!-- /.panel -->
    </div> <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

