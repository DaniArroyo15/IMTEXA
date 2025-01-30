using General.Librerias.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppWeb.Areas.Almacen.Controllers
{
    public class ProductoController : Controller
    {
        daSQL odaSQL = new daSQL("con.GEN");

        // GET: Almacen/Producto
        public ActionResult Producto()
        {
            return View();
        }

        public string ListaCategoria()
        {
            string rpta = "";
            rpta = odaSQL.EjecutarComando("paCategoria_ListarCombo");
            return rpta;
        }
        public string ListaProducto(string CategoriaId)
        {
            string rpta = "";
            rpta = odaSQL.EjecutarComando("paProducto_ListaPorCategoria", "@peIdCategoria", CategoriaId);
            return rpta;
        }
    }
}