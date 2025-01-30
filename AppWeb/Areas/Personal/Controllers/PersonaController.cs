using General.Librerias.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppWeb.Areas.Personal.Controllers
{
    public class PersonaController : Controller
    {
        // GET: Personal/Persona

        daSQL odaSql = new daSQL("con.GEN");
        public ActionResult Index()
        {
            return View();
        }

        public string ListaPersona() {
            string rpta = "";
            rpta = odaSql.EjecutarComando("paPersonal_Listar");
            return rpta;
        }

        public string GrabaPersona() {
            string rpta = "";
            var user = Session["Usuario"].ToString().Split('|')[1];
            string data = Request.Form["Data"];
            data = string.Format("{0}|{1}", data, user);
            rpta = odaSql.EjecutarComando("paPersonal_Grabar", "@pData", data);
            return rpta;
        }


    }
}