using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Proyecto_Inmobiliaria.Models
{
	public class RepositorioInmueble : RepositorioBase
	{
		public RepositorioInmueble(IConfiguration configuration) : base(configuration)
		{

		}

		public int Alta(Inmueble entidad)
		{
			int res = -1;
			using (var connection = new MySqlConnection(connectionString))
			{
				string sql = @"INSERT INTO Inmuebles 
					(direccion, ambientes, uso, tipo, superficie, latitud, longitud, estado, idPropietario)
					VALUES (@direccion, @ambientes, @uso, @tipo, @superficie, @latitud, @longitud, @estado, @idPropietario);
					SELECT LAST_INSERT_ID();";//devuelve el id insertado (LAST_INSERT_ID para mysql)
				using (var command = new MySqlCommand(sql, connection))
				{
					command.CommandType = CommandType.Text;
					command.Parameters.AddWithValue("@direccion", entidad.Direccion == null? DBNull.Value : entidad.Direccion);
					command.Parameters.AddWithValue("@ambientes", entidad.Ambientes);
                    command.Parameters.AddWithValue("@uso", entidad.Uso);
                    command.Parameters.AddWithValue("@tipo", entidad.Tipo);
					command.Parameters.AddWithValue("@superficie", entidad.Superficie);
					command.Parameters.AddWithValue("@latitud", entidad.Latitud);
					command.Parameters.AddWithValue("@longitud", entidad.Longitud);
					command.Parameters.AddWithValue("@idPropietario", entidad.IdPropietario);
					connection.Open();
					res = Convert.ToInt32(command.ExecuteScalar());
					entidad.Id = res;
					connection.Close();
				}
			}
			return res;
		}
		public int Baja(int id)
		{
			int res = -1;
			using (var connection = new MySqlConnection(connectionString))
			{
				string sql = @$"DELETE FROM Inmuebles WHERE id = @id";
				using (MySqlCommand command = new MySqlCommand(sql, connection))
				{
					command.CommandType = CommandType.Text;
					command.Parameters.AddWithValue("@id", id);
					connection.Open();
					res = command.ExecuteNonQuery();
					connection.Close();
				}
			}
			return res;
		}
		public int Modificacion(Inmueble entidad)
		{
			int res = -1;
			using (var connection = new MySqlConnection(connectionString))
			{
				string sql = @"
					UPDATE Inmuebles SET
					direccion=@direccion, tipo=@tipo, uso=@uso, ambientes=@ambientes, superficie=@superficie, latitud=@latitud, longitud=@longitud, estado=@estado. idPropietario=@idPropietario
					WHERE id = @id";
				using (MySqlCommand command = new MySqlCommand(sql, connection))
				{
					command.Parameters.AddWithValue("@direccion", entidad.Direccion);
					command.Parameters.AddWithValue("@ambientes", entidad.Ambientes);
                    command.Parameters.AddWithValue("@tipo", entidad.Tipo);
                    command.Parameters.AddWithValue("@uso", entidad.Uso);
					command.Parameters.AddWithValue("@superficie", entidad.Superficie);
					command.Parameters.AddWithValue("@latitud", entidad.Latitud);
					command.Parameters.AddWithValue("@longitud", entidad.Longitud);
					command.Parameters.AddWithValue("@idPropietario", entidad.IdPropietario);
					command.Parameters.AddWithValue("@id", entidad.Id);
					command.CommandType = CommandType.Text;
					connection.Open();
					res = command.ExecuteNonQuery();
					connection.Close();
				}
			}
			return res;
		}
        /*
		public int ModificarPortada(int id, string url)
        {
            int res = -1;
            using (var connection = new SqlConnection(connectionString))
            {
                string sql = @"
					UPDATE Inmuebles SET
					Portada=@portada
					WHERE Id = @id";
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@portada", String.IsNullOrEmpty(url) ? DBNull.Value : url);
                    command.Parameters.AddWithValue("@id", id);
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    res = command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            return res;
        }*/

		public IList<Inmueble> ObtenerTodos()
        {
            IList<Inmueble> res = new List<Inmueble>();
            using (var connection = new MySqlConnection(connectionString))
            {
                string sql = @"SELECT id, direccion, uso, tipo, ambientes, superficie, latitud, longitud, estado, idPropietario, 
                            p.nombre, p.apellido, p.DNI
                            FROM Inmuebles i INNER JOIN Propietarios p ON i.idPropietario = p.id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    var reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Inmueble entidad = new Inmueble
                        {
                            Id = reader.GetInt32(nameof(Inmueble.Id)),
                            Direccion = reader[nameof(Inmueble.Direccion)] == DBNull.Value ? "" : reader.GetString(nameof(Inmueble.Direccion)),
                            Ambientes = reader.GetInt32(nameof(Inmueble.Ambientes)),
                            Uso = reader.GetInt32(nameof(Inmueble.Uso)),
                            Tipo = reader.GetString(nameof(Inmueble.Tipo)),
                            Superficie = reader.GetInt32(nameof(Inmueble.Superficie)),
                            Latitud = reader.IsDBNull(reader.GetOrdinal(nameof(Inmueble.Latitud))) ? (decimal?)null : reader.GetDecimal(nameof(Inmueble.Latitud)),
                            Longitud = reader.IsDBNull(reader.GetOrdinal(nameof(Inmueble.Longitud))) ? (decimal?)null : reader.GetDecimal(nameof(Inmueble.Longitud)),
                            Estado = reader.GetString(nameof(Inmueble.Estado)),
                            IdPropietario = reader.GetInt32(nameof(Inmueble.IdPropietario)),
                            Duenio = new Propietario
                            {
                                Id = reader.GetInt32(nameof(Propietario.Id)),
                                Nombre = reader.GetString(nameof(Propietario.Nombre)),
                                Apellido = reader.GetString(nameof(Propietario.Apellido)),
                                //Dni = reader.GetString(nameof(Propietario.Dni)),
                            }
                        };
                        res.Add(entidad);
                    }
                    connection.Close();
                }
            }
            return res;
        }

		public Inmueble ObtenerPorId(int id)
        {
            Inmueble entidad = null;
            using (var connection = new MySqlConnection(connectionString))
            {
                string sql = @$"
                    SELECT {nameof(Inmueble.Id)}, Direccion, Ambientes, Uso, Tipo, Superficie, Latitud, Longitud, Estado, IdPropietario, p.Nombre, p.Apellido
                    FROM Inmuebles i JOIN Propietarios p ON i.PropietarioId = p.IdPropietario
                    WHERE {nameof(Inmueble.Id)} = @id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@id", id);
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    var reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        entidad = new Inmueble
                        {
                            Id = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.Id))),
                            Direccion = reader.IsDBNull(reader.GetOrdinal(nameof(Inmueble.Direccion))) ? "" : reader.GetString(reader.GetOrdinal(nameof(Inmueble.Direccion))),
                            Ambientes = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.Ambientes))),
                            Tipo = reader.GetString(reader.GetOrdinal(nameof(Inmueble.Tipo))),
                            Uso = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.Uso))),
                            Superficie = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.Superficie))),
                            Latitud = reader.IsDBNull(reader.GetOrdinal(nameof(Inmueble.Latitud))) ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal(nameof(Inmueble.Latitud))),
                            Longitud = reader.IsDBNull(reader.GetOrdinal(nameof(Inmueble.Longitud))) ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal(nameof(Inmueble.Longitud))),
                            IdPropietario = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.IdPropietario))),
                            Duenio = new Propietario
                            {
                                Id = reader.GetInt32(reader.GetOrdinal(nameof(Inmueble.IdPropietario))),
                                Nombre = reader.GetString(reader.GetOrdinal(nameof(Propietario.Nombre))),
                                Apellido = reader.GetString(reader.GetOrdinal(nameof(Propietario.Apellido))),
                                //DNI = reader.GetString(reader.GetOrdinal(nameof(Propietario.Dni))),
                            }
                        };
                    }
                    connection.Close();
                }
            }
            return entidad;
        }

		public IList<Inmueble> BuscarPorPropietario(int idPropietario)
		{
			List<Inmueble> res = new List<Inmueble>();
			Inmueble entidad = null;
			using (var connection = new MySqlConnection(connectionString))
			{
				string sql = @$"
					SELECT {nameof(Inmueble.Id)}, Direccion, Ambientes, Superficie, Latitud, Longitud, PropietarioId, p.Nombre, p.Apellido
					FROM Inmuebles i JOIN Propietarios p ON i.PropietarioId = p.IdPropietario
					WHERE PropietarioId=@idPropietario";
				using (SqlCommand command = new SqlCommand(sql, connection))
				{
					command.Parameters.Add("@idPropietario", SqlDbType.Int).Value = idPropietario;
					command.CommandType = CommandType.Text;
					connection.Open();
					var reader = command.ExecuteReader();
					while (reader.Read())
					{
						entidad = new Inmueble
						{
							Id = reader.GetInt32(nameof(Inmueble.Id)),
							Direccion = reader["Direccion"] == DBNull.Value? "" : reader.GetString("Direccion"),
							Ambientes = reader.GetInt32("Ambientes"),
							Superficie = reader.GetInt32("Superficie"),
							Latitud = reader.GetDecimal("Latitud"),
							Longitud = reader.GetDecimal("Longitud"),
							PropietarioId = reader.GetInt32("PropietarioId"),
							Duenio = new Propietario
							{
								IdPropietario = reader.GetInt32("PropietarioId"),
								Nombre = reader.GetString("Nombre"),
								Apellido = reader.GetString("Apellido"),
							}
						};
						res.Add(entidad);
					}
					connection.Close();
				}
			}
			return res;
		}
	}
}
