//========= Copyright � 1996-2002, Valve LLC, All rights reserved. ============
//
// Purpose: Shadow control entity.
//
// $NoKeywords: $
//=============================================================================
#include "cbase.h"

//------------------------------------------------------------------------------
// FIXME: This really should inherit from something	more lightweight
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Purpose : Shadow control entity
//------------------------------------------------------------------------------
class C_ShadowControl : public C_BaseEntity
{
public:
	DECLARE_CLASS( C_ShadowControl, C_BaseEntity );

	DECLARE_CLIENTCLASS();

	void OnDataChanged(DataUpdateType_t updateType);
	bool ShouldDraw();

private:
	Vector m_shadowDirection;
	color32 m_shadowColor;
	float m_flShadowMaxDist;
};

IMPLEMENT_CLIENTCLASS_DT(C_ShadowControl, DT_ShadowControl, CShadowControl)
	RecvPropVector(RECVINFO(m_shadowDirection)),
	RecvPropInt(RECVINFO(m_shadowColor)),
	RecvPropFloat(RECVINFO(m_flShadowMaxDist)),
END_RECV_TABLE()


//------------------------------------------------------------------------------
// Purpose :
// Input   :
// Output  :
//------------------------------------------------------------------------------
void C_ShadowControl::OnDataChanged(DataUpdateType_t updateType)
{
	// Set the color, direction, distance...
	g_pClientShadowMgr->SetShadowDirection( m_shadowDirection );
	g_pClientShadowMgr->SetShadowColor( m_shadowColor.r, m_shadowColor.g, m_shadowColor.b );
	g_pClientShadowMgr->SetShadowDistance( m_flShadowMaxDist );
}

//------------------------------------------------------------------------------
// We don't draw...
//------------------------------------------------------------------------------
bool C_ShadowControl::ShouldDraw()
{
	return false;
}
