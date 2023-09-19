rule Catch_SPN_Scanning_with_LDAP {
	meta:
		author = "Yehuda Livne"
		description = "Detects potential SPN scanning using LDAP"
		date = "2023-09-19"

	strings:
		$ldap_query_filter1 = "(servicePrincipalName=*)" nocase
		$ldap_query_filter2 = "(sAMAccountName=*)" nocase

	condition:
		$ldap_query_filter1 or $ldap_query_filter2
}
