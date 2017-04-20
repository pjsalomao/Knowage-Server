package it.eng.spagobi.api.v2;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;
import org.jboss.resteasy.util.GenericType;

import it.eng.spagobi.api.AbstractSpagoBIResource;
import it.eng.spagobi.commons.ADconverter.AccessibleDocumentConverter;
import it.eng.spagobi.commons.ADconverter.AccessibleDocumentConverterFactory;
import it.eng.spagobi.commons.ADconverter.ConversionType;
import it.eng.spagobi.services.rest.annotations.ManageAuthorization;
import it.eng.spagobi.utilities.engines.SpagoBIEngineServiceException;
import it.eng.spagobi.utilities.exceptions.SpagoBIRuntimeException;

@Path("/2.0/exportAccessibleDocument")
@ManageAuthorization
public class AccessibleDocumentExportResource extends AbstractSpagoBIResource {
	static private String SERVICENAME = "exportAccessibleDocument";
	static private Logger logger = Logger.getLogger(AccessibleDocumentExportResource.class);
	
	@GET
	@Path("/{conversionType}/getResult/{jobId}")
	@Produces({ "aplication/pdf" })
	public Response getResult(@PathParam("jobId")String jobId,@PathParam("conversionType") String conversionType){
		
		ConversionType convesionType;
		AccessibleDocumentConverterFactory ADCFactory;
		AccessibleDocumentConverter dc;
		File outputFile;
		ResponseBuilder responseBuilder;
		
		convesionType = ConversionType.valueOf(conversionType);
		ADCFactory = new AccessibleDocumentConverterFactory();
		dc = ADCFactory.getAccessibleDocumentConverter(convesionType);
		
		outputFile = dc.getConversionResult(jobId);

		responseBuilder = Response.ok(outputFile)
		.header("Content-Disposition", "attachment; filename="+ outputFile.getName())
		.header("filename", outputFile.getName());
		
		return responseBuilder.build();
	}
	@POST
	@Path("/{conversionType}/startconversion")
	@Consumes({ MediaType.MULTIPART_FORM_DATA})
	@Produces({ MediaType.TEXT_PLAIN })
	public Response startConversion(@MultipartForm MultipartFormDataInput multipartFormDataInput, @PathParam("conversionType") String conversionType) {
		
		byte[] file =null;
		String fileName = null;
		String size = null;
		ConversionType convesionType = null;
		Map<String,String> params = new HashMap<>();
		
			
		try {
		convesionType = ConversionType.valueOf(conversionType);
		file = getFile(multipartFormDataInput);
		fileName = "table.html";//getFileName(multipartFormDataInput.getFormDataMap().get("file").get(0).getHeaders());
		size = getSize(multipartFormDataInput);
		if(size ==null ){
			size = "4";
		}
		params.put("filename", fileName);
		params.put("size", size);
		
		AccessibleDocumentConverterFactory ADCFactory = new AccessibleDocumentConverterFactory();
		AccessibleDocumentConverter dc = ADCFactory.getAccessibleDocumentConverter(convesionType);
		
		String jobId = dc.startConversion(file,params);
		
		return Response.ok(jobId).build() ;
		} 
		catch (Exception e) {
			logger.error("error in service",e);
			throw new SpagoBIEngineServiceException(SERVICENAME, "ERROR");
		}
	}
	
	private String getSize(MultipartFormDataInput multipartFormDataInput) {
		try {
			 return multipartFormDataInput.getFormDataPart("size", new GenericType<String>(){});
		} catch (IOException e) {
			logger.error("error while getting size parameter",e);
			throw new SpagoBIRuntimeException("error while getting size parameter",e);
		}
		
	}

	private byte[] getFile( MultipartFormDataInput multipartFormDataInput){
		byte[] file = null;
		
		
		try {
			
			file = multipartFormDataInput.getFormDataPart("file", new GenericType<byte[]>(){});
			
			
		} catch (IOException e) {
			logger.error("error while getting file parameter",e);
			throw new SpagoBIRuntimeException("error while getting file parameter",e);
		}
		return file;
	}
	
	private String getFileName(MultivaluedMap<String, String> headers) {
		
		String[] contentDisposition = headers.getFirst("Content-Disposition").split(";");

		for (String filename : contentDisposition) {
			if ((filename.trim().startsWith("filename"))) {

				String[] name = filename.split("=");

				String finalFileName = name[1].trim().replaceAll("\"", "");
				return finalFileName;
			}
		}
		return null;
	}
	
	
	
}
